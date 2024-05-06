<?php

namespace App\Http\Controllers;


use App\Models\Linies;
use Illuminate\Http\Request;

class LiniesController extends Controller
{
    public function addLinia(Request $request)
    {
        $linia= new Linies();
        $linia->idComanda=$request->idComanda;
        $linia->quantitat=$request->quantitat;
        $linia->idArticle=$request->idArticle;
        $linia->save();
    }

}
