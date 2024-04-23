<?php

namespace App\Http\Controllers;

use App\Models\Productes;
use Illuminate\Support\Facades\DB;
use Inertia\Inertia;

class ProductesController extends Controller
{
    public function ListProductes(){
        $productes = DB::table('productes')
            ->leftJoin('categoria_productes', 'productes.idCategoriaProducte', '=', 'categoria_productes.idCategoriaProductes')
            ->leftJoin('expansions', 'productes.idExpansio', '=', 'expansions.idExpansio')
            ->select('productes.nom AS nom', 'productes.descripcio AS descripcio', 'productes.imatge AS imatge', 'categoria_productes.nom AS categoriaProducteNom', 'expansions.nom AS expansioNom')
            ->get();

        return Inertia::render('llistaProductes', ['productes' => $productes]);
    }


    public function APIListProductes(){
        $productes= Productes::all();
        return response()->json($productes);
    }
}
