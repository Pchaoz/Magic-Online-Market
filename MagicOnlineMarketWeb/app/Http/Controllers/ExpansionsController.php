<?php

namespace App\Http\Controllers;

use App\Models\Expansions;
use Illuminate\Http\Request;
use Inertia\Inertia;

class ExpansionsController extends Controller
{
    public function ListExpansions(){
        $expansions= Expansions::all();
        return Inertia::render('administradorExpansions',['expansions'=>$expansions]);

    }
}
