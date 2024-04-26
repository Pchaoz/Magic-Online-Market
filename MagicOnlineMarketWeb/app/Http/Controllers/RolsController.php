<?php

namespace App\Http\Controllers;

use App\Models\Rols;
use Illuminate\Http\Request;
use Inertia\Inertia;


class RolsController extends Controller
{

    public function ListRols(){
        $rols= Rols::all();
        return Inertia::render('administradorRols',['rols'=>$rols]);

    }


    public function APIListRols(){
        $rols= Rols::all();
        return response()->json($rols);
    }

    public function getRol($id){
        $rol= Rols::where('idRol',$id)->get();
        return response()->json($rol);
    }


    public function addRol(Request $request){
        $rol= new Rols();
        $rol->nom=$request->nom;
        $rol->save();

    }
    public function modRol($id,$nom){
        $rol= Rols::where('idRol',$id)->first();
        $rol->nom=$nom;
        $rol->save();
        return "Nom de rol modificat exitosament!";
    }

    public function eliminarRol($id){
        $rol= Rols::find($id);
        $rol->delete();
        return "Rol eliminat exitosament!";
    }

}
