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
            ]
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
            $user->saldo += $request->amount;
            $user->save();
        }

        return response()->json($result);
    }
}
