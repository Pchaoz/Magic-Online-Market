<?php

namespace App\Http\Controllers;

use App\Models\User;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\DB;
use Inertia\Inertia;

class UserController extends Controller
{
    public function getAllUser(){
        $usuaris= User::all();
        return response()->json($usuaris);
    }



    public function getUsersForm(){
       $usuaris= DB::table('usuaris')
            ->leftJoin('rols', 'usuaris.idRol', '=', 'rols.idRol')
            ->select('usuaris.idUsuari AS idUsuari','usuaris.nick AS nick', 'usuaris.name AS descripcio', 'usuaris.cognom AS cognom', 'usuaris.email AS email', 'rols.nom AS nomRol')
            ->get();
        return Inertia::render('administradorUsuaris',['usuaris'=>$usuaris]);
    }


    public function deleteUser($id){
        $user= User::find($id);
        $user->delete();
    }



    public function getUserRolId(){
        $usuari= User::find(Auth::id());
        $idRol=$usuari->idRol;
        return $idRol;
    }




}
