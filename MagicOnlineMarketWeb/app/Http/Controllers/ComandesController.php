<?php

namespace App\Http\Controllers;

use App\Models\Articles;
use App\Models\Comandes;
use App\Models\Linies;
use Carbon\Carbon;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\DB;
use Inertia\Inertia;

class ComandesController extends Controller
{
    public function addComanda(Request $request)
    {
        //primer creem la comanda
        $comanda = new Comandes();
        $comanda->idVenedor = $request->idVenedor;
        $comanda->preuTotal = $request->totalComanda;
        $comanda->estatComanda='pendent confirmacio';
        $comanda->idComprador = Auth::id();
        $comanda->updated_at = Carbon::now()->format('Y-m-d H:i:s');
        $comanda->save();

        //despres per cada linia creem una linia
        foreach ($request->linies as $liniaRequest) {
            $linia = new Linies();
            $linia->idComanda = $comanda->idComanda;
            $linia->quantitat = $liniaRequest['qtyLinia'];
            $linia->idArticle = $liniaRequest['idArticle'];
            $linia->save();
            //finalment, restem els articles corresponents
            $article = Articles::where('idArticle', $linia->idArticle)->first();
            $article->quantitatDisponible -= $linia->quantitat;
            $article->save();
        }
    }

    public function listComandes ()
    {
        $comandes = DB::table('comandes')
        ->leftJoin('usuaris as venedor', 'comandes.idVenedor', '=', 'venedor.idUsuari')
        ->leftJoin('usuaris as comprador', 'comandes.idComprador', '=', 'comprador.idUsuari')
        ->select('venedor.nick AS nickVenedor', 'comprador.nick AS nickComprador','comandes.preuTotal AS total', 'comandes.estatComanda AS estat',
        'comandes.isEnviament AS isEnviament','comandes.idEnviament AS idEnviament','comandes.idComanda AS idComanda')
            ->get();

        return Inertia::render('llistaComandes', ['comandes' => $comandes]);

    }


    public function eliminarComanda (Request $request)
    {
        $comanda = Comandes::where('idComanda', $request->idComanda)->first();
        $comanda->delete();

    }


    public function agregarArticleComanda(Request $request)
    {
        //primer hem de comprobar si l'usuari te una comanda en estat en compra del mateix venedor
        $comanda = Comandes::where('idVenedor', $request->idVenedor)
            ->where('idComprador', Auth::id())
            ->where('EstatComanda', "En compra")
            ->first();
        if ($comanda) {
           //si existeix actualizem comanda amb noves dades
            $comanda->preuTotal+=($request->quantitatAfegida*$request->preuArticle);
            $comanda->updated_at=Carbon::now()->format('Y-m-d H:i:s');
            $comanda->updated_by=Auth::id();
            $comanda->save();
        } else {
            // Crea una nueva comanda
            $comanda = new Comandes();
            $comanda->idVenedor = $request->idVenedor;
            $comanda->preuTotal=($request->quantitatAfegida*$request->preuArticle);
            $comanda->idComprador = Auth::id();
            $comanda->updated_at = Carbon::now()->format('Y-m-d H:i:s');
            $comanda->EstatComanda = "En compra";
            $comanda->save();
        }
        // ara afegim quantitat a una nova linia pero hem de saber si creem una nova linia
        // o nomes afegim la quantitat
        $linia = Linies::where('idComanda', $comanda->idComanda)
            ->where('idArticle', $request->idArticle)
            ->first();
        if ($linia) {
            $linia->quantitat += $request->quantitatAfegida;
            $linia->updated_by = Auth::id();
            $linia->updated_at = Carbon::now()->format('Y-m-d H:i:s');
            $linia->save();
        }else{
            $linia = new Linies();
            $linia->idComanda = $comanda->idComanda;
            $linia->quantitat = $request->quantitatAfegida;
            $linia->idArticle = $request->idArticle;
            $linia->created_by = Auth::id();
            $linia->updated_by = Auth::id();
            $linia->updated_at = Carbon::now()->format('Y-m-d H:i:s');
            $linia->save();
        }

        //hem d'actualizar la quantitat d'article
        $article = Articles::find($request->idArticle);
        $article->quantitatDisponible-= $request->quantitatAfegida;
        $article->updated_by = Auth::id();
        $article->updated_at = Carbon::now()->format('Y-m-d H:i:s');
        $article->save();

    }



}
