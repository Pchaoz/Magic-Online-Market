<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use Inertia\Inertia;

class BarallesController extends Controller
{
    public function ListBaralles()
    {
        $baralles = DB::table('baralles')
            ->leftJoin('usuaris as creador', 'baralles.idCreador', '=', 'creador.idUsuari')
            ->select('creador.nick AS nickCreador', 'baralles.nom AS nomBaralla', 'baralles.idBaralla as idBaralla', 'creador.idUsuari as idUsuari','baralles.isPublic as isPublic')
            ->get();

        return Inertia::render('llistaBaralles',['baralles'=>$baralles]);

    }

    public function seeBaralla ($id)
    {
        $CartesBaralla = DB::table('baralla_cartes')
            ->leftJoin('cartes', 'cartes.idCarta', '=', 'baralla_cartes.idCarta')
            ->select('baralla_cartes.quantitat AS quantitat', 'cartes.nom AS nomCarta', 'cartes.imatge as imatgeCarta')
            ->where('baralla_cartes.idBaralla','=',$id)
            ->get();
        $baralla = DB::table('baralles')
            ->select('baralles.nom AS nomBaralla')
            ->where('baralles.idBaralla','=',$id)
            ->first();

        return Inertia::render('vistaBaralla',['cartesBaralla'=>$CartesBaralla,'baralla' =>$baralla]);


    }
}
