<?php

namespace App\Http\Controllers;

use App\Models\Rols;
use Carbon\Carbon;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
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

    public function editarRol(Request $request)
    {
        $rol= Rols::where('idRol',$request->id)->first();
        $rol->nom = $request->nom;
        $rol->updated_at = Carbon::now()->format('Y-m-d H:i:s');
        $rol->updated_by=Auth::id();
        $rol->save();

    }

    public function deleteRol($id){
        $rol= Rols::find($id);
        $rol->delete();

    }

}
