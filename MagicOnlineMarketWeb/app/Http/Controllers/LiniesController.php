<?php

namespace App\Http\Controllers;


use App\Models\Articles;
use App\Models\Comandes;
use App\Models\Linies;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use Inertia\Inertia;

class LiniesController extends Controller
{

    public function veureLiniesComanda ($id)
    {
        $comanda = DB::table('comandes')
        ->leftJoin('usuaris as venedor', 'comandes.idVenedor', '=', 'venedor.idUsuari')
        ->leftJoin('usuaris as comprador', 'comandes.idComprador', '=', 'comprador.idUsuari')
        ->select('venedor.nick AS nickVenedor', 'comprador.nick AS nickComprador','comandes.preuTotal AS total',
            'comandes.estatComanda AS estat','comprador.idRol as idComprador')
        ->where('comandes.idComanda', '=', $id)
        ->first();
        $linies = DB::table('linies')
        ->leftJoin('articles', 'linies.idArticle', '=', 'articles.idArticle')
        ->leftJoin('productes', 'productes.idProducte', '=', 'articles.idProducte')
        ->select('productes.nom AS nomProducte', 'linies.quantitat AS quantitat','articles.preuUnitari','linies.idLinia AS idLinia','linies.idComanda AS idComanda'  )
        ->where('linies.idComanda', '=', $id)
        ->get();

        return Inertia::render('llistaLiniesComanda', ['comanda' => $comanda, 'linies' =>$linies]);

    }


    public function eliminarLinia (Request $request)
    {
        $linia = Linies::where('idLinia', $request->idLinia)->first();
        $article = Articles::where('idArticle', $linia->idArticle)->first();
        $article->quantitatDisponible+=$linia->quantitat;
        $article->save();
        $totalLinia = ($request->quantitatLinia*$request->preuLinia);
        $linia->delete();

        $comanda = Comandes::where('idComanda', $request->idComanda)->first();
        $comanda->preuTotal-=$totalLinia;
        $linies = Linies::where('idComanda', $comanda->idComanda) ->first();
        if($linies){
            $comanda->save();
        }else{
            $comanda->delete();
            return Inertia::render('Dashboard');
        }

    }
}
