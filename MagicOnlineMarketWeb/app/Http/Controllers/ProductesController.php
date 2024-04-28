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

    public function whereProductes($idCategoriaProductes){
        $productes = DB::table('productes')
            ->leftJoin('categoria_productes', 'productes.idCategoriaProducte', '=', 'categoria_productes.idCategoriaProductes')
            ->leftJoin('expansions', 'productes.idExpansio', '=', 'expansions.idExpansio')
            ->select('productes.nom AS nom', 'productes.descripcio AS descripcio', 'productes.imatge AS imatge', 'categoria_productes.nom AS categoriaProducteNom', 'expansions.nom AS expansioNom')
            ->where('productes.idCategoriaProducte','=',$idCategoriaProductes)
            ->get();

        return Inertia::render('llistaProductes', ['productes' => $productes]);
    }


    public function APIListProductes(){
        $productes= Productes::all();
        return response()->json($productes);
    }

    public function APILastProductes(){
        $productes = Productes::orderBy('created_at', 'desc')->take(10)->get();
        return response()->json($productes);
    }

    public function getProducte($id){
        $producte= Productes::where('idProducte',$id)->get();
        return response()->json($producte);
    }

    public function addProducte($nom,$descripcio,$idcategoria){
        $producte= new Productes();
        $producte->nom=$nom;
        $producte->descripcio=$descripcio;
        $producte->idCategoriaProducte=$idcategoria;
        $producte->save();
        return "Producte creat exitosament!";
    }
    public function modProducte($id,$descripcio){
        $producte= Productes::where('idProducte',$id)->first();
        $producte->descripcio=$descripcio;
        $producte->save();
        return "Descripcio de producte modificada exitosament!";
    }

    public function eliminarProducte($id){
        $producte= Productes::find($id);
        $producte->delete();
        return "Producte eliminat exitosament!";
    }

}
