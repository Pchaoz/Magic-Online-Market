<?php

namespace App\Http\Controllers;

use App\Models\Cartes;
use Carbon\Carbon;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Inertia\Inertia;

class CartesController extends Controller
{
    public function ListCartes(){
        $cartes= Cartes::all();
        $userController = new UserController;
        $idRol = $userController->getUserRolId();
        return Inertia::render('llistaCartes',['cartes'=>$cartes,'idRolUser'=>$idRol]);
    }

    public function APIListCartes(){
        $cartes= Cartes::all();
        return response()->json($cartes);
    }

    public function getAllCartesByRaresa($raresa){
        $cartes= Cartes::where('raresa',$raresa)->get();
        return Inertia::render('llistaCartes',['cartes'=>$cartes]);
    }



    public function addCarta(Request $request)
    {

        $carta = new Cartes();
        $carta->nom = $request->nom;
        $carta->descripcio = $request->descripcio;
        $carta->raresa = $request->raresa;
        if($request->hasFile('imatge')){
            $imageName = time().'.'.$request->imatge->extension();
            $request->imatge->move(public_path('images/cartes'), $imageName);
            $carta->imatge = 'cartes/' . $imageName;
        }
        $carta->updated_at = Carbon::now()->format('Y-m-d H:i:s');
        $carta->created_by=Auth::id();
        $carta->updated_by=Auth::id();
        $carta->save();

    }

    public function FormEditCarta(Request $request){

        $carta= Cartes::where('idCarta',$request->idCartaModificada)->first();
        return Inertia::render('FormulariModificacioCartes',['carta'=>$carta]);
    }
    public  function editarCarta(Request $request){

        $carta= Cartes::where('idCarta',$request->id)->first();
        $carta->nom = $request->nom;
        $carta->descripcio = $request->descripcio;
        $carta->raresa = $request->raresa;
        if($request->hasFile('imatge')){
            $imageName = time().'.'.$request->imatge->extension();
            $request->imatge->move(public_path('images/cartes'), $imageName);
            $carta->imatge = 'cartes/' . $imageName;
        }
        $carta->updated_at = Carbon::now()->format('Y-m-d H:i:s');
        $carta->updated_by=Auth::id();
        $carta->save();

    }


    public function alterDescripcioCarta($id,$descipcio){
        $carta= Cartes::where('idCarta',$id)->first();
        $carta->descripcio=$descipcio;
        $carta->save();
        return "Carta modificada correctamente!";
    }

    public function deleteCarta($id){
        $carta= Cartes::find($id);
        $imagen =$carta->imatge;
        $rutaImagen = public_path('images/' . $imagen);
        if (file_exists($rutaImagen)) {
            unlink($rutaImagen);
        }

        $carta->delete();

    }



}
