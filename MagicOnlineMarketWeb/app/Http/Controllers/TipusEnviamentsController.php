<?php

namespace App\Http\Controllers;

use App\Models\TipusEnviaments;
use Illuminate\Http\Request;
use Inertia\Inertia;

class TipusEnviamentsController extends Controller
{
    public function ListTipusEnviaments(){
        $tipusEnviaments= TipusEnviaments::all();
        return Inertia::render('administradorTipusEnviaments',['tipusEnviaments'=>$tipusEnviaments]);

    }

    public function crearTipusEnviament(Request $request){
        $tipusEnviament= new TipusEnviaments();
        $tipusEnviament->nom=$request->nom;
        $tipusEnviament->preu=$request->preu;
        $tipusEnviament->save();

    }
    public function eliminarTipusEnviament(Request $request)
    {
        $tipusEnviament = TipusEnviaments::find($request->id);
        $tipusEnviament->delete();
    }
    public function modTipusEnviament(Request $request)
    {
        $tipusEnviament = TipusEnviaments::find($request->id);
        $tipusEnviament->nom=$request->nom;
        $tipusEnviament->preu=$request->preu;
        $tipusEnviament->save();
    }








}
