<?php

namespace App\Http\Controllers;

use App\Models\Comandes;
use Carbon\Carbon;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;

class ComandesController extends Controller
{
    public function addComanda(Request $request)
    {
        $comanda= new Comandes();
        $comanda->idVenedor=$request->idVenedor;
        $comanda->preuTotal=$request->totalComanda;
        $comanda->idComprador=Auth::id();
        $comanda->updated_at = Carbon::now()->format('Y-m-d H:i:s');
        $comanda->save();
        return response()->json(['idComanda' => $comanda->idComanda]);

    }
}
