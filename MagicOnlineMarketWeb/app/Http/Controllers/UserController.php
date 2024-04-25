<?php

namespace App\Http\Controllers;

use App\Models\User;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;

class UserController extends Controller
{
    public function getAllUser(){
        $usuaris= User::all();
        return response()->json($usuaris);
    }


    public function getUserRolId(){
        $usuari= User::find(Auth::id());
        $idRol=$usuari->idRol;
        return $idRol;
    }
}
