<?php

namespace App\Http\Controllers;

use App\Models\Expansions;
use Carbon\Carbon;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Inertia\Inertia;

class ExpansionsController extends Controller
{
    public function ListExpansions(){
        $expansions = Expansions::orderBy('dataSortida', 'desc')->get();
        return Inertia::render('administradorExpansions',['expansions'=>$expansions]);

    }
    public function crearExpansio(Request $request)
    {
        $expansio = new Expansions();
        $expansio->nom = $request->nom;
        $expansio->dataSortida = $request->dataSortida;
        $expansio->updated_by = Auth::id();
        $expansio->created_by =Auth::id();
        $expansio->updated_at =Carbon::now()->format('Y-m-d H:i:s');
        $expansio->save();
    }


    public function editarExpansio(Request $request)
    {
        $expansio= Expansions::where('idExpansio',$request->id)->first();
        $expansio->nom = $request->nom;
        $expansio->dataSortida = $request->dataSortida;
        $expansio->updated_by = Auth::id();
        $expansio->updated_at =Carbon::now()->format('Y-m-d H:i:s');
        $expansio->save();
    }


    public function eliminarExpansio(Request $request){
        $expansio= Expansions::where('idExpansio',$request->id)->first();
        $expansio->delete();

    }

    }
