<?php

namespace App\Http\Controllers;

use App\Models\Wishlist;
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
    public function crearWishlist(Request $request)
    {
       $wishlist = new Wishlist();
       $wishlist->nom =$request->nom;
       $wishlist->idPropietari =Auth::id();
       $wishlist->save();
    }

    public function eliminarWishlist(Request $request)
    {
        $wishlist = Wishlist::find($request->idWishlist);
        $wishlist->delete();
    }

    public function modWishlist(Request $request)
    {
        $wishlist = Wishlist::find($request->idWishlist);
        $wishlist->nom =$request->nom;
        $wishlist->updated_by=Auth::id();
        $wishlist->save();
    }

    public function veureWishlist($id)
    {
        $wishlist = Wishlist::find($id);
        if(Auth::user()->idRol==2||Auth::user()->idRol==1||Auth::user()->idUser==$wishlist->idPropietari){
            return Inertia::render('vistaWishlist',['wishlist'=>$wishlist]);
        }else{
            return redirect()->route('ListWhishlistsMeves');
        }
    }






}
