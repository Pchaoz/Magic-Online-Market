<?php

namespace App\Http\Controllers;

use App\Models\User;
use Carbon\Carbon;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Redirect;
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
            ->select('usuaris.idRol AS idRol','usuaris.idUsuari AS idUsuari','usuaris.nick AS nick', 'usuaris.name AS nom', 'usuaris.cognom AS cognom', 'usuaris.email AS email', 'rols.nom AS nomRol')
            ->get();

       $rols =DB::table('rols')
           ->select('rols.nom AS nom','rols.idRol AS idRol')
           ->get();

        $nicks= DB::table('usuaris')
            ->select('usuaris.nick AS nick')
            ->where('usuaris.idUsuari','<>',Auth::id())
            ->get();
        return Inertia::render('administradorUsuaris',['usuaris'=>$usuaris,'rols'=>$rols,'nicks'=>$nicks]);
    }


    public function deleteUser(Request $request){
        $user= User::find($request->idUsuari);
        $user->delete();
        return redirect()->route('getUsersForm');
    }

    public function getUserRolId(){
        $usuari= User::find(Auth::id());
        $idRol=$usuari->idRol;
        return $idRol;
    }

    public function editarUsuari(Request $request){
        $usuari= User::find($request->idUsuari);
        $usuari->nick=$request->nick;
        $usuari->cognom=$request->cognom;
        $usuari->name=$request->nom;
        $usuari->idRol=$request->idRol;
        $usuari->updated_by = Auth::id();
        $usuari->updated_at = Carbon::now()->format('Y-m-d H:i:s');
        $usuari->save();

    }



    public function APIgetUser($id) {
        $user = DB::table('usuaris')
            ->where('idUsuari','=', $id )
            ->get();
        return response()->json($user);
    }

    public function getSaldoAPI($id) {
        $user = DB::table('usuaris')
            ->select( 'name', 'saldo')
            ->where('idUsuari','=', $id )
            -get();
        return response()->json($user);
    }


}
