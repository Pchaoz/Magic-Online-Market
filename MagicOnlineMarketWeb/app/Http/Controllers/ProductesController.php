<?php

namespace App\Http\Controllers;

use App\Models\Productes;
use Carbon\Carbon;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\DB;
use Inertia\Inertia;

class ProductesController extends Controller
{
    public function ListProductes(){
        $productes = DB::table('productes')
            ->leftJoin('categoria_productes', 'productes.idCategoriaProducte', '=', 'categoria_productes.idCategoriaProductes')
            ->leftJoin('expansions', 'productes.idExpansio', '=', 'expansions.idExpansio')
            ->select('productes.nom AS nom', 'productes.descripcio AS descripcio', 'productes.imatge AS imatge', 'categoria_productes.nom AS categoriaProducteNom',
                'expansions.nom AS expansioNom','productes.idProducte as idProducte','productes.idCategoriaProducte as idCategoriaProducte','productes.idExpansio as idExpansio','productes.idCarta as idCarta')
            ->get();
        $categoriesProducte = DB::table('categoria_productes')
            ->select('categoria_productes.nom as nom','categoria_productes.idCategoriaProductes')
            ->get();
        $expansions = DB::table('expansions')
            ->select('expansions.nom as nom','expansions.idExpansio as idExpansio')
            ->get();
        $cartes = DB::table('cartes')
            ->select('cartes.nom as nom','cartes.idCarta as idCarta')
            ->get();
        $wishlists = Db::table('wishlists')
            ->where('idPropietari','=',Auth::id())
            ->get();
        return Inertia::render('llistaProductes', ['productes' => $productes,'categoriesProducte' =>$categoriesProducte,'expansions' =>$expansions, 'cartes'=>$cartes,'wishlists'=>$wishlists]);
    }

    public function formModificarProducte(Request $request){
        $producte = DB::table('productes')
            ->leftJoin('categoria_productes', 'productes.idCategoriaProducte', '=', 'categoria_productes.idCategoriaProductes')
            ->leftJoin('expansions', 'productes.idExpansio', '=', 'expansions.idExpansio')
            ->select('productes.nom AS nom', 'productes.descripcio AS descripcio', 'productes.imatge AS imatge', 'categoria_productes.nom AS categoriaProducteNom',
                'expansions.nom AS expansioNom','productes.idProducte as idProducte','productes.idCategoriaProducte as idCategoriaProducte','productes.idExpansio as idExpansio','productes.idCarta as idCarta')
            ->where("productes.idProducte",'=',$request->idProducte)
            ->first();
        $categoriesProducte = DB::table('categoria_productes')
            ->select('categoria_productes.nom as nom','categoria_productes.idCategoriaProductes')
            ->get();
        $expansions = DB::table('expansions')
            ->select('expansions.nom as nom','expansions.idExpansio as idExpansio')
            ->get();
        $cartes = DB::table('cartes')
            ->select('cartes.nom as nom','cartes.idCarta as idCarta')
            ->get();

        return Inertia::render('formulariModificacioProductes',['producte'=>$producte,'categoriesProducte' =>$categoriesProducte,'expansions' =>$expansions, 'cartes'=>$cartes]);
    }

    public function formCrearProducte(){
        $categoriesProducte = DB::table('categoria_productes')
            ->select('categoria_productes.nom as nom','categoria_productes.idCategoriaProductes')
            ->get();
        $expansions = DB::table('expansions')
            ->select('expansions.nom as nom','expansions.idExpansio as idExpansio')
            ->get();
        $cartes = DB::table('cartes')
            ->select('cartes.nom as nom','cartes.idCarta as idCarta')
            ->get();

        return Inertia::render('formulariCreacioProductes', ['categoriesProducte' =>$categoriesProducte,'expansions' =>$expansions, 'cartes'=>$cartes]);
    }


    public function APIListProductes(){

        $productes = Productes::with('categoriaProducte')->get();
        return response()->json($productes);
        
        $result = $productes->map(function($producte) {
            return [
                'idProducte' => $producte->idProducte,
                'nom' => $producte->nom,
                'descripcio' => $producte->descripcio,
                'imatge' => $producte->imatge,
                'idCategoriaProducte' => $producte->idCategoriaProducte,
                'nomCategoria' => $producte->categoriaProducte ? $producte->categoriaProducte->nom : null,
                'idExpansio' => $producte->idExpansio,
                'idCarta' => $producte->idCarta,
                'updated_by' => $producte->updated_by,
                'created_by' => $producte->created_by,
                'created_at' => $producte->created_at,
                'updated_at' => $producte->updated_at,
            ];
        });
        return response()->json($result);
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

    public function eliminarProducte(Request $request){

        $producte= Productes::where('idProducte',$request->idProducte)->first();
        $producte->delete();

    }
    public function modificarProducte(Request $request){
        $producte= Productes::where('idProducte',$request->idProducte)->first();
        $producte->nom=$request->nom;
        $producte->descripcio=$request->descripcio;
        if($request->hasFile('imatge')){
            $imageName = time().'.'.$request->imatge->extension();
            $request->imatge->move(public_path('images/productes'), $imageName);
            $producte->imatge = 'productes/' . $imageName;
        }
        $producte->updated_at = Carbon::now()->format('Y-m-d H:i:s');
        $producte ->updated_by=Auth::id();
        $request->idCategoriaProducte=="Sense Categoria"?$producte->idCategoriaProducte=null:$producte->idCategoriaProducte=$request->idCategoriaProducte;
        $request->idExpansio=="Sense Expansio"?$producte->idExpansio=null:$producte->idExpansio=$request->idExpansio;
        $request->idCarta=="No Carta"?$producte->idCarta=null:$producte->idCarta=$request->idCarta;
        $producte->save();

    }


    public function crearProducte(Request $request){
        $producte= new Productes();
        $producte->nom=$request->nom;
        $producte->descripcio=$request->descripcio;
        if($request->hasFile('imatge')){
            $imageName = time().'.'.$request->imatge->extension();
            $request->imatge->move(public_path('images/productes'), $imageName);
            $producte->imatge = 'productes/' . $imageName;
        }
        $producte ->created_by=Auth::id();
        $producte ->updated_by=Auth::id();
        $request->idCategoriaProducte=="Sense Categoria"?$producte->idCategoriaProducte=null:$producte->idCategoriaProducte=$request->idCategoriaProducte;
        $request->idExpansio=="Sense Expansio"?$producte->idExpansio=null:$producte->idExpansio=$request->idExpansio;
        $request->idCarta=="No Carta"?$producte->idCarta=null:$producte->idCarta=$request->idCarta;
        $producte->save();

    }

}
