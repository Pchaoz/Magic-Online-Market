<?php

namespace App\Http\Controllers;

use App\Models\TipusEnviaments;
use Inertia\Inertia;

class TipusEnviamentsController extends Controller
{
    public function ListTipusEnviaments(){
        $tipusEnviaments= TipusEnviaments::all();
        return Inertia::render('administradorTipusEnviaments',['tipusEnviaments'=>$tipusEnviaments]);

    }
}
