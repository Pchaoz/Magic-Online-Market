<?php

namespace App\Http\Controllers;

use App\Models\BarallaCartes;
use App\Models\Baralles;
use Carbon\Carbon;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
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


    public function ListBarallesMeves()
    {
        $baralles = DB::table('baralles')
            ->leftJoin('usuaris as creador', 'baralles.idCreador', '=', 'creador.idUsuari')
            ->where('baralles.idCreador','=',Auth::id())
            ->select('creador.nick AS nickCreador', 'baralles.nom AS nomBaralla', 'baralles.idBaralla as idBaralla', 'creador.idUsuari as idUsuari','baralles.isPublic as isPublic')
            ->get();

        return Inertia::render('llistaBaralles',['baralles'=>$baralles]);

    }


    public function seeBaralla ($id)
    {
        $CartesBaralla = DB::table('baralla_cartes')
            ->leftJoin('cartes', 'cartes.idCarta', '=', 'baralla_cartes.idCarta')
            ->select('baralla_cartes.quantitat AS quantitat', 'cartes.nom AS nomCarta', 'cartes.imatge as imatgeCarta','cartes.idCarta as idCarta')
            ->where('baralla_cartes.idBaralla','=',$id)
            ->get();
        $baralla = DB::table('baralles')
            ->select('baralles.nom AS nomBaralla','baralles.idBaralla as idBaralla',"baralles.idCreador as idCreador")
            ->where('baralles.idBaralla','=',$id)
            ->first();
        $cartes = DB::table('cartes')
            ->select('cartes.nom as nom','cartes.idCarta as idCarta','cartes.imatge as imatge')
            ->get();

        return Inertia::render('vistaBaralla',['cartesBaralla'=>$CartesBaralla,'baralla' =>$baralla,'cartes'=>$cartes]);


    }
    public function agregarCartaBaralla (Request $request)
    {
        $cartaBaralla = BarallaCartes::where('idCarta',$request->idCarta)
            ->where('idBaralla',$request->idBaralla)
            ->first();
        if ($cartaBaralla) {
            $cartaBaralla->quantitat+=$request->quantitat;
            $cartaBaralla->updated_by=Auth::id();
            $cartaBaralla->save();
        }else{
            $cartaBaralla = new BarallaCartes();
            $cartaBaralla->quantitat=$request->quantitat;
            $cartaBaralla->idCarta=$request->idCarta;
            $cartaBaralla->idBaralla=$request->idBaralla;
            $cartaBaralla->created_by=Auth::id();
            $cartaBaralla->updated_by=Auth::id();
            $cartaBaralla->save();
        }
    }

    public function modCartaBaralla (Request $request)
    {
        $cartaBaralla = BarallaCartes::where('idCarta',$request->idCarta)
            ->where('idBaralla',$request->idBaralla)
            ->first();

        $cartaBaralla->quantitat=$request->quantitat;
        $cartaBaralla->updated_by=Auth::id();
        $cartaBaralla->updated_at=Carbon::now()->format('Y-m-d H:i:s');
        $cartaBaralla->save();
    }



    public function deleteCartaBaralla (Request $request)
    {
        $cartaBaralla = BarallaCartes::where('idCarta',$request->idCarta)
            ->where('idBaralla',$request->idBaralla)
            ->first();
        $cartaBaralla->delete();
    }

    public function crearBaralla (Request $request)
    {
        $baralla = new Baralles();
        $baralla->nom=$request->nom;
        $baralla->idCreador=Auth::id();
        $baralla->created_by=Auth::id();
        $baralla->updated_by=Auth::id();
        $baralla->save();
    }
    public function editarBaralla (Request $request)
    {
        $baralla = Baralles::where('idBaralla',$request->idBaralla)
            ->first();
        $baralla->nom=$request->nom;
        $baralla->updated_by=Auth::id();
        $baralla->save();
    }

    public function deleteBaralla (Request $request)
    {
        $baralla = Baralles::where('idBaralla',$request->idBaralla)
            ->first();
        $cartesBaralla = BarallaCartes::where('idBaralla',$request->idBaralla)
            ->get();
        foreach ( $cartesBaralla as $cartaBaralla) {
            $cartaBaralla->delete();
        }
        $baralla->delete();
    }



}
