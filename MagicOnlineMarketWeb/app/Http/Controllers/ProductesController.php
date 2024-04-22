<?php

namespace App\Http\Controllers;

use App\Models\Productes;
use Illuminate\Http\Request;
use Inertia\Inertia;

class ProductesController extends Controller
{
    public function ListProductes(){
        $productes= Productes::all();
        return Inertia::render('llistaProductes',['productes'=>$productes]);
    }


    public function APIListProductes(){
        $productes= Productes::all();
        return response()->json($productes);
    }
}
