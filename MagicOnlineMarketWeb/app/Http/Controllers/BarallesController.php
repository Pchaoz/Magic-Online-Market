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
            ->select('baralles.nom AS nomBaralla','baralles.idBaralla as idBaralla',"baralles.idCreador as idCreador", "baralles.isPublic as isPublic")
            ->where('baralles.idBaralla','=',$id)
            ->first();
        $cartes = DB::table('cartes')
            ->select('cartes.nom as nom','cartes.idCarta as idCarta','cartes.imatge as imatge')
            ->get();

        if(($baralla->isPublic==0 &&(Auth::user()->idRol=='1'||Auth::id()==$baralla->idCreador))||$baralla->isPublic==1){
            return Inertia::render('vistaBaralla',['cartesBaralla'=>$CartesBaralla,'baralla' =>$baralla,'cartes'=>$cartes]);
        }else{
            return redirect()->route('ListBaralles');
        }




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
        $baralla->isPublic=$request->public;
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
        $baralla->isPublic=$request->public;
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

    public function getAllBaralles()
    {
        $baralles = DB::table('baralles')
            ->leftJoin('usuaris as creador', 'baralles.idCreador', '=', 'creador.idUsuari')
            ->select('creador.nick AS nickCreador', 'baralles.nom AS nomBaralla', 'baralles.idBaralla as idBaralla', 'creador.idUsuari as idUsuari','baralles.isPublic as isPublic')
            ->get();
        return response()->json($baralles);
    }

    public function getBarallesByUserID($id) {
        $baralles = DB::table('baralles')
        ->leftJoin('usuaris as creador', 'baralles.idCreador', '=', 'creador.idUsuari')
        ->where('baralles.idCreador','=', $id)
        ->select('creador.nick AS nickCreador', 'baralles.nom AS nomBaralla', 'baralles.idBaralla as idBaralla', 'creador.idUsuari as idUsuari','baralles.isPublic as isPublic')
        ->get();

        return response()->json($baralles);
    }

    public function createBatallaAPI (Request $request) {

        //return response()->json(['message' => $request], 200); //FOR TESTING

        $baralla = new Baralles();
        $baralla->nom=$request->deckName;
        $baralla->idCreador= $request->idUser;
        $baralla->created_by=$request->idUser;
        $baralla->updated_by=$request->idUser;
        $baralla->isPublic=$request->isPublic;
        $baralla->save();

        return response()->json(['message' => 'Usuario actualizado con éxito'], 200);
    }

    public function addCardAPI (Request $request) {

        $cartaBaralla = BarallaCartes::where('idCarta',$request->idCarta)
        ->where('idBaralla',$request->idBaralla)
        ->first();
        if ($cartaBaralla) {
            $cartaBaralla->quantitat+=$request->quantitat;
            $cartaBaralla->updated_by=$request->idUser;
            $cartaBaralla->save();
        }else{
            $cartaBaralla = new BarallaCartes();
            $cartaBaralla->quantitat=$request->quantitat;
            $cartaBaralla->idCarta=$request->idCarta;
            $cartaBaralla->idBaralla=$request->idBaralla;
            $cartaBaralla->created_by=$request->idUser;
            $cartaBaralla->updated_by=$request->idUser;
            $cartaBaralla->save();
        }
    }

    public function updateCartaBarallaAPI(Request $request)
    {
        $cartaBaralla = BarallaCartes::where('idCarta',$request->idCarta)
            ->where('idBaralla',$request->idBaralla)
            ->first();
        $cartaBaralla->quantitat=$request->quantitat;
        $cartaBaralla->updated_by=$request->userID;
        $cartaBaralla->updated_at=Carbon::now()->format('Y-m-d H:i:s');
        $cartaBaralla->save();
    }

    public function  deleteCartaBarallaAPI (Request $request)
    {
        $cartaBaralla = BarallaCartes::where('idCarta',$request->idCarta)
            ->where('idBaralla',$request->idBaralla)
            ->first();
        $cartaBaralla->delete();
    }

    public function seeBarallaByID ($id) {

        $CartesBaralla = DB::table('baralla_cartes')
        ->leftJoin('cartes', 'cartes.idCarta', '=', 'baralla_cartes.idCarta')
        ->select('baralla_cartes.quantitat AS quantitat', 'cartes.nom AS nomCarta', 'cartes.imatge as imatgeCarta','cartes.idCarta as idCarta')
        ->where('baralla_cartes.idBaralla','=',$id)
        ->get();
        $baralla = DB::table('baralles')
        ->select('baralles.nom AS nomBaralla','baralles.idBaralla as idBaralla',"baralles.idCreador as idCreador", "baralles.isPublic as isPublic")
        ->where('baralles.idBaralla','=',$id)
        ->first();
        $cartes = DB::table('cartes')
        ->select('cartes.nom as nom','cartes.idCarta as idCarta','cartes.imatge as imatge')
        ->get();

        return response()->json(['cartesBaralla' => $CartesBaralla, 'baralla' => $baralla, 'cartes' => $cartes], 200);

    }

    public function editarBarallaAPI(Request $request) {
        $baralla = Baralles::where('idBaralla',$request->idBaralla)
        ->first();
        $baralla->nom=$request->nom;
        $baralla->isPublic=$request->public;
        $baralla->updated_by=$request->idUser;
        $baralla->save();

        return response()->json(['message' => 'Baralla actualizada amb exit'], 200);
    }
    
    public function deleteBarallaAPI (Request $request) {
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
