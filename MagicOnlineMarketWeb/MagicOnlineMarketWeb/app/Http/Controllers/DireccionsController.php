<?php

namespace App\Http\Controllers;

use App\Models\Direccions;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\DB;
use Inertia\Inertia;

class DireccionsController extends Controller
{

    public function ListUserdirections()
    {
        $direccions = DB::table('direccions')
            ->leftJoin('usuaris as propietari', 'propietari.idUsuari', '=', 'direccions.idPropietari')
            ->leftJoin('ciutats', 'ciutats.idCiutat', '=', 'direccions.idCiutat')
            ->leftJoin('paissos', 'paissos.idPais', '=', 'ciutats.idPais')
            ->where('direccions.idPropietari','=',Auth::id())
            ->select('direccions.direccio AS direccio', 'direccions.codiPostal AS codiPostal', 'ciutats.nom as nomCiutat','paissos.nom as nomPais'
            ,'propietari.nick as nick','direccions.idDireccio as idDireccio')
            ->get();
        $ciutats = DB::table('ciutats')
            ->select('ciutats.nom as nom','ciutats.idCiutat as idCiutat')
            ->get();
        return Inertia::render('llistaDirections',['direccions'=>$direccions,'ciutats'=>$ciutats]);

    }
    public function crearDireccio(Request $request)
    {
        $direccio = new Direccions();
        $direccio->direccio=$request->direccio;
        $direccio->codiPostal=$request->codiPostal;
        $direccio->idPropietari=Auth::id();
        $direccio->idCiutat=$request->idCiutat;
        $direccio->save();
    }
    public function eliminarDireccio(Request $request)
    {
        $direccio = Direccions::find($request->id);
        $direccio->delete();
    }
    public function modDireccio(Request $request)
    {
        $direccio = Direccions::find($request->id);
        $direccio->direccio=$request->direccio;
        $direccio->codiPostal=$request->codiPostal;
        $direccio->idCiutat=$request->idCiutat;
        $direccio->save();
    }

}
