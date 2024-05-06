<?php

namespace App\Http\Controllers;

use App\Models\Articles;
use App\Models\Comandes;
use App\Models\Linies;
use Carbon\Carbon;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;

class ComandesController extends Controller
{
    public function addComanda(Request $request)
    {
        //primer creem la comanda
        $comanda= new Comandes();
        $comanda->idVenedor=$request->idVenedor;
        $comanda->preuTotal=$request->totalComanda;
        $comanda->idComprador=Auth::id();
        $comanda->updated_at = Carbon::now()->format('Y-m-d H:i:s');
        $comanda->save();

        //despres per cada linia creem una linia
        foreach($request->linies as $liniaRequest) {
            $linia= new Linies();
            $linia->idComanda=$comanda->idComanda;
            $linia->quantitat=$liniaRequest['qtyLinia'];
            $linia->idArticle=$liniaRequest['idArticle'];
            $linia->save();
        //finalment, restem els articles corresponents
            $article= Articles::where('idArticle',$linia->idArticle)->first();
            $article->quantitatDisponible-=$linia->quantitat;
            $article->save();
        }
    }
}
