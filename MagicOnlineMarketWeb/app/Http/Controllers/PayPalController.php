<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Srmklive\PayPal\Services\PayPal as PayPalClient;
use App\Models\User;

class PayPalController extends Controller
{
    public function createOrder(Request $request)
    {
        $request->validate([
            'amount' => 'required|numeric|min:1',
        ]);

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

        if (isset($order['id'])) {
            return response()->json($order);
        }

        return response()->json(['message' => 'Error creating PayPal order'], 500);
    }

    public function captureOrder(Request $request)
    {
        $request->validate([
            'orderID' => 'required|string',
            'userID' => 'required|integer|exists:users,id',
        ]);

        $provider = new PayPalClient;
        $provider->setApiCredentials(config('paypal'));
        $paypalToken = $provider->getAccessToken();
        $provider->setAccessToken($paypalToken);

        $result = $provider->capturePaymentOrder($request->orderID);

        if ($result['status'] === 'COMPLETED') {
            $user = User::find($request->userID);
            $amount = $result['purchase_units'][0]['payments']['captures'][0]['amount']['value'];
            $user->saldo += $amount;
            $user->save();

            return response()->json($result);
        }

        return response()->json(['message' => 'Error capturing PayPal order', 'result' => $result], 400);
    }

    public function success(Request $request)
    {
        $orderID = $request->query('token'); 
        return view('paypal.success', ['orderID' => $orderID]);
    }

    public function cancel()
    {
        return view('paypal.cancel');
    }

    public function withdraw(Request $request)
    {
        $request->validate([
            'userID' => 'required|integer|exists:users,id',
            'amount' => 'required|numeric|min:1',
        ]);

        $user = User::find($request->userID);
        $amount = $request->amount;

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

        if (isset($payout['batch_header']['batch_status']) && $payout['batch_header']['batch_status'] === 'SUCCESS') {
            $user->saldo -= $amount;
            $user->save();
            return response()->json(['message' => 'Retiro exitoso', 'payout' => $payout], 200);
        }

        return response()->json(['message' => 'Error al procesar el retiro', 'payout' => $payout], 400);
    }
}
