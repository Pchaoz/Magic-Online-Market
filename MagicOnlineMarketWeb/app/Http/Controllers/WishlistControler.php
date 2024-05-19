<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\DB;
use Inertia\Inertia;

class WishlistControler extends Controller
{
    public function ListWhishlistsMeves()
    {
        $wishlists = DB::table('wishlists')
            ->leftJoin('usuaris as propietari', 'wishlists.idPropietari', '=', 'propietari.idUsuari')
            ->where('wishlists.idPropietari','=',Auth::id())
            ->select( 'wishlists.nom AS nomWishlist', 'wishlists.idWishlist as idWishlist', 'propietari.idUsuari as idUsuari','propietari.nick as nickPropietari')
            ->get();

        return Inertia::render('llistaWishlist',['wishlists'=>$wishlists]);

    }


    public function ListWhishlists()
    {
        $wishlists = DB::table('wishlists')
            ->leftJoin('usuaris as propietari', 'wishlists.idPropietari', '=', 'propietari.idUsuari')
            ->select( 'wishlists.nom AS nomWishlist', 'wishlists.idWishlist as idWishlist', 'propietari.idUsuari as idUsuari','propietari.nick as nickPropietari')
            ->get();

        return Inertia::render('llistaWishlist',['wishlists'=>$wishlists]);

    }
}
