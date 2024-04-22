<?php

namespace App\Http\Controllers;

use App\Models\Rols;


class RolsController extends Controller
{

    public function ListRols(){
        $rols= Rols::all();
        return response()->json($rols);
    }


    public function APIListRols(){
        $rols= Rols::all();
        return response()->json($rols);
    }

    public function addRol($nom){
        $rol= new Rols();
        $rol->nom=$nom;
        $rol->save();
        return "Rol creat exitosament!";
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
