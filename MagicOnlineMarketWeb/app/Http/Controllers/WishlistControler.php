<?php

namespace App\Http\Controllers;

use App\Models\Wishlist;
use App\Models\WishlistProducte;
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
        if(Auth::user()->idRol==2||Auth::user()->idRol==1||Auth::user()->idUsuari==$wishlist->idPropietari){
            $whishlistProductes = DB::table('whishlist_producte')
                ->leftJoin('wishlists', 'wishlists.idWishlist', '=', 'whishlist_producte.idWishlist')
                ->leftJoin('productes', 'productes.idProducte', '=', 'whishlist_producte.idProducte')
                ->select('productes.imatge AS imatgeProducte', 'productes.nom AS nomProducte', 'wishlists.nom as nomWishlist',
               'whishlist_producte.idWishlistProducte as idwp','whishlist_producte.idProducte as idProducte'  )
                ->where('whishlist_producte.idWishlist','=',$wishlist->idWishlist)
                ->get();

            return Inertia::render('vistaWishlist',['whishlistProductes'=>$whishlistProductes,'wishlist'=> $wishlist]);
        }else{
            return redirect()->route('ListWhishlistsMeves');
        }
    }
    public function eliminarProducteWishlist(Request $request)
    {
        $wishlistProducte = WishlistProducte::find($request->idWishlistProducte);
        $wishlistProducte->delete();
    }
    public function afegirProducteWishlist(Request $request)
    {
        $wishlist = Wishlist::find($request->idWishlist);

        $existingProduct = WishlistProducte::where('idProducte', $request->idProducte)
            ->where('idWishlist', $request->idWishlist)
            ->first();

        if ($existingProduct) {

        } else {
            $wishlistProducte = new WishlistProducte();
            $wishlistProducte->idProducte = $request->idProducte;
            $wishlistProducte->idWishlist = $request->idWishlist;
            $wishlistProducte->save();

        }
    }

    public function getWishlistsByUserID($id) {

        $wishlists = DB::table('wishlists')
            ->leftJoin('usuaris as propietari', 'wishlists.idPropietari', '=', 'propietari.idUsuari')
            ->where('wishlists.idPropietari','=',$id)
            ->select( 'wishlists.nom AS nomWishlist', 'wishlists.idWishlist as idWishlist', 'propietari.idUsuari as idUsuari','propietari.nick as nickPropietari')
            ->get();

        return response()->json(['wishlists' => $wishlists], 200);
    }

    public function getWishListByWishListID($id) {

        return response()->json(['message' => $id], 400);

        $wishlist = Wishlist::find($id);

        $whishlistProductes = DB::table('whishlist_producte')
            ->leftJoin('wishlists', 'wishlists.idWishlist', '=', 'whishlist_producte.idWishlist')
            ->leftJoin('productes', 'productes.idProducte', '=', 'whishlist_producte.idProducte')
            ->select('productes.imatge AS imatgeProducte', 'productes.nom AS nomProducte', 'wishlists.nom as nomWishlist',
                'whishlist_producte.idWishlistProducte as idwp','whishlist_producte.idProducte as idProducte'  )
            ->where('whishlist_producte.idWishlist','=',$wishlist->idWishlist)
            ->get();

        return response()->json(['wishlist' => $wishlist, 'whishlistProductes' =>  $whishlistProductes], 200);

    }
    public function createNewWishList(Request $request)
    {
        $wishlist = new Wishlist();
        $wishlist->nom =$request->name;
        $wishlist->idPropietari = $request->idUser;
        $wishlist->save();

        return response()->json(['message' => "Wishlist creada correctament"], 200);
    }

    public function addProductToWishlist(Request $request)
    {
        $wishlist = Wishlist::find($request->idWishlist);

        $existingProduct = WishlistProducte::where('idProducte', $request->idProducte)
            ->where('idWishlist', $request->idWishlist)
            ->first();

        if (!$existingProduct) {
            $wishlistProducte = new WishlistProducte();
            $wishlistProducte->idProducte = $request->idProducte;
            $wishlistProducte->idWishlist = $request->idWishlist;
            $wishlistProducte->save();

            return response()->json(['message' => "Producte agregat a wishlist" . $wishlist->nom . " correctament"], 200);
        }
        return response()->json(['message' => "Producte no agregat. Ya existeix en aquesta wishlist.."], 400);
    }

}
