<?php

namespace App\Http\Controllers;

use App\Models\Cartes;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;

class CartesController extends Controller
{
    public function getAllCartes(){
        $cartes= Cartes::all();
        return response()->json($cartes);
    }
    public function getAllCartesByRaresa($raresa){
        $cartes= Cartes::where('raresa',$raresa)->get();
        return response()->json($cartes);
    }
    public function addCarta(Request $request)
    {
        $carta = new Cartes();
        $carta->nom = $request->nom;
        $carta->descripcio = $request->descripcio;
        $carta->imatge = $request->imatge;
        $carta->raresa = $request->raresa;
        $carta->save();
        return "Carta creada correctament!";
    }
    public function deleteCarta($id){
        $carta= Cartes::find($id);
        $carta->delete();
        return "Carta eliminada";
    }



}
