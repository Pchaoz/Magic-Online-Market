<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Srmklive\PayPal\Services\PayPal as PayPalClient;
use App\Models\User;
use Illuminate\Support\Facades\Auth;

class PayPalController extends Controller
{
    public function createOrder(Request $request)
    {
        $provider = new PayPalClient;
        $provider->setApiCredentials(config('paypal'));
        $paypalToken = $provider->getAccessToken();
        $provider->setAccessToken($paypalToken);

        $order = $provider->createOrder([
            "intent" => "CAPTURE",
            "purchase_units" => [
                [
                    "amount" => [
                        "currency_code" => "EUR",
                        "value" => $request->amount
                    ]
                ]
            ],
            'application_context' => [
                'return_url' => url('/api/paypal/success'),
                'cancel_url' => url('/api/paypal/cancel'),
            ],
        ]);

        return response()->json($order);
    }

    public function captureOrder(Request $request)
    {
        $provider = new PayPalClient;
        $provider->setApiCredentials(config('paypal'));
        $paypalToken = $provider->getAccessToken();
        $provider->setAccessToken($paypalToken);

        $result = $provider->capturePaymentOrder($request->orderID);

        if ($result['status'] === 'COMPLETED') {
            $user = User::find($request->userID);
            $amount = $result['purchase_units'][0]['payments']['captures'][0]['amount']['value']; // Capturar el valor de la cantidad
            $user->saldo += $amount;
            $user->save();
        }

        return response()->json($result);
    }


    public function success(Request $request)
    {
        $orderID = $request->query('token'); // Capturar el token del pedido
        return view('paypal.success', ['orderID' => $orderID]);
    }

    public function cancel()
    {
        return view('paypal.cancel');
    }

    public function withdraw(Request $request)
    {
        $user = User::find($request->userID);
        $amount = $request->amount;

        // Verifica que el usuario tenga saldo suficiente
        if ($user->saldo < $amount) {
            return response()->json(['message' => 'Saldo insuficiente'], 400);
        }

        $provider = new PayPalClient;
        $provider->setApiCredentials(config('paypal'));
        $paypalToken = $provider->getAccessToken();
        $provider->setAccessToken($paypalToken);

        $payout = $provider->createPayout([
            'sender_batch_header' => [
                'email_subject' => 'You have a payout!',
            ],
            'items' => [
                [
                    'recipient_type' => 'EMAIL',
                    'amount' => [
                        'value' => $amount,
                        'currency' => 'EUR'
                    ],
                    'receiver' => $user->paypal_email,
                    'note' => 'Thanks for using our service!',
                ],
            ],
        ]);

        // Verificar si el pago fue exitoso
        if ($payout['batch_header']['batch_status'] === 'SUCCESS') {
            $user->saldo -= $amount;
            $user->save();
            return response()->json(['message' => 'Retiro exitoso', 'payout' => $payout], 200);
        }

        return response()->json(['message' => 'Error al procesar el retiro', 'payout' => $payout], 500);
    }
}
