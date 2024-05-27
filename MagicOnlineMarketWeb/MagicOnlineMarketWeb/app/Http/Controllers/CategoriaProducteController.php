<?php

namespace App\Http\Controllers;

use App\Models\CategoriaProductes;
use Carbon\Carbon;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Inertia\Inertia;

class CategoriaProducteController extends Controller
{
    public function APICategoriaProductes(){
        $categories = CategoriaProductes::all();
        return response()->json($categories);
    }

    public function ListCategProductes(){
        $categoriesProductes = CategoriaProductes::orderBy('nom', 'desc')->get();
        return Inertia::render('administradorCategoriaProductes',['categoriesProductes'=>$categoriesProductes]);

    }
    public function crearCategProductes(Request $request)
    {
        $categoriaProducte = new CategoriaProductes();
        $categoriaProducte->nom = $request->nom;
        $categoriaProducte->updated_by = Auth::id();
        $categoriaProducte->created_by =Auth::id();
        $categoriaProducte->updated_at =Carbon::now()->format('Y-m-d H:i:s');
        $categoriaProducte->save();
    }


    public function editarCategProductes(Request $request)
    {
        $categoriaProducte= CategoriaProductes::where('idCategoriaProductes',$request->id)->first();
        $categoriaProducte->nom = $request->nom;
        $categoriaProducte->updated_by = Auth::id();
        $categoriaProducte->updated_at =Carbon::now()->format('Y-m-d H:i:s');
        $categoriaProducte->save();
    }


    public function eliminarCategProductes(Request $request){
        $categoriaProducte= CategoriaProductes::where('idCategoriaProductes',$request->id)->first();
        $categoriaProducte->delete();

    }
}
