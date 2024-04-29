<?php

namespace App\Http\Controllers;

use App\Models\CategoriaProductes;
use Illuminate\Http\Request;

class CategoriaProducteController extends Controller
{
    public function APICategoriaProductes(){
        $categories = CategoriaProductes::all();
        return response()->json($categories);
    }
}
