<?php

namespace App\Http\Controllers;

use App\Models\Cartes;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use Inertia\Inertia;

class CartesController extends Controller
{
    public function getAllCartes(){
        $cartes= Cartes::all();
        return Inertia::render('llistaCartes',['cartes'=>$cartes]);
    }
    public function getAllCartesByRaresa($raresa){
        $cartes= Cartes::where('raresa',$raresa)->get();
        return response()->json($cartes);
    }
    public function addCarta(Request $request)
    {
        $request->validate([
            'nom' => 'required',
            'descripcio' => 'required',
            'imatge' => 'required|image|mimes:jpeg,png,jpg,gif,svg|max:2048',
            'raresa' => 'required',
        ]);

        $carta = new Cartes();
        $carta->nom = $request->nom;
        $carta->descripcio = $request->descripcio;
        $carta->raresa = $request->raresa;

        if($request->hasFile('imatge')){
            $imageName = time().'.'.$request->imatge->extension();
            $request->imatge->move(public_path('images/cartes'), $imageName);
            $carta->imatge = 'cartes/' . $imageName;
        }

        $carta->save();

        return "Carta creada correctamente!";
    }

    public function alterDescripcioCarta($id,$descipcio){
        $carta= Cartes::where('idCarta',$id)->first();
        $carta->descripcio=$descipcio;
        $carta->save();
        return "Carta modificada correctamente!";
    }

    public function deleteCarta($id){
        $carta= Cartes::find($id);
        $carta->delete();
        return "Carta eliminada";
    }



}
