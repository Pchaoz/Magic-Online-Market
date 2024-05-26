<?php

namespace App\Http\Controllers;

use App\Models\Articles;
use App\Models\Comandes;
use App\Models\Enviaments;
use App\Models\Linies;
use App\Models\User;
use Carbon\Carbon;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\DB;
use Inertia\Inertia;

class ComandesController extends Controller
{
    public function addComanda(Request $request)
    {
        //primer creem la comanda
        $comanda = new Comandes();
        $comanda->idVenedor = $request->idVenedor;
        $comanda->preuTotal = $request->totalComanda;
        $comanda->estatComanda='Pendent pagament';
        $comanda->idComprador = Auth::id();
        $comanda->updated_at = Carbon::now()->format('Y-m-d H:i:s');
        $comanda->save();

        //despres per cada linia creem una linia
        foreach ($request->linies as $liniaRequest) {
            $linia = new Linies();
            $linia->idComanda = $comanda->idComanda;
            $linia->quantitat = $liniaRequest['qtyLinia'];
            $linia->idArticle = $liniaRequest['idArticle'];
            $linia->save();
            //finalment, restem els articles corresponents
            $article = Articles::where('idArticle', $linia->idArticle)->first();
            $article->quantitatDisponible -= $linia->quantitat;
            $article->save();
        }
    }

    public function listComandes ()
    {
        $comandes = DB::table('comandes')
            ->leftJoin('usuaris as venedor', 'comandes.idVenedor', '=', 'venedor.idUsuari')
            ->leftJoin('usuaris as comprador', 'comandes.idComprador', '=', 'comprador.idUsuari')
            ->select('venedor.nick AS nickVenedor', 'comprador.nick AS nickComprador','comandes.preuTotal AS total', 'comandes.estatComanda AS estat',
                'comandes.isEnviament AS isEnviament','comandes.idEnviament AS idEnviament','comandes.idComanda AS idComanda','comandes.idVenedor as idVenedor',
                'comandes.idComprador as idComprador','comandes.isEnviament as isEnviament')
            ->get();
        $titol="Totes les comandes";
        return Inertia::render('llistaComandes', ['comandes' => $comandes,'titol'=>$titol]);

    }

    public function listComandesCompres ()
    {
        $comandes = DB::table('comandes')
            ->leftJoin('usuaris as venedor', 'comandes.idVenedor', '=', 'venedor.idUsuari')
            ->leftJoin('usuaris as comprador', 'comandes.idComprador', '=', 'comprador.idUsuari')
            ->select('venedor.nick AS nickVenedor', 'comprador.nick AS nickComprador','comandes.preuTotal AS total', 'comandes.estatComanda AS estat',
                'comandes.isEnviament AS isEnviament','comandes.idEnviament AS idEnviament','comandes.idComanda AS idComanda','comandes.idVenedor as idVenedor',
                'comandes.idComprador as idComprador','comandes.isEnviament as isEnviament')
            ->where('idComprador', Auth::id())
            ->get();
        $titol="Les meves Compres";
        $direccions  = DB::table('direccions')
            ->leftJoin('ciutats', 'ciutats.idCiutat', '=', 'direccions.idCiutat')
            ->leftJoin('paissos', 'paissos.idPais', '=', 'ciutats.idPais')
            ->select('direccions.direccio AS direccio', 'direccions.codiPostal AS codiPostal', 'ciutats.nom as nomCiutat','paissos.nom as nomPais'
                ,'direccions.idDireccio as idDireccio')
            ->where('direccions.idPropietari', Auth::id())
            ->get();
        $tipusEnviaments = DB::table('tipus_enviaments')
            ->select('tipus_enviaments.nom as nom','tipus_enviaments.preu as preu','tipus_enviaments.idTipusEnviament as idTipusEnviament')
            ->get();
        $saldo = DB::table('usuaris')
            ->select('usuaris.saldo as saldoComprador')
            ->where('idUsuari', Auth::id())
            ->first();

        return Inertia::render('llistaComandes', ['comandes' => $comandes, 'direccions' => $direccions,  'titol'=>$titol, 'tipusEnviaments' => $tipusEnviaments,'saldo' => $saldo]);

    }
    public function listComandesVendes ()
    {
        $comandes = DB::table('comandes')
            ->leftJoin('usuaris as venedor', 'comandes.idVenedor', '=', 'venedor.idUsuari')
            ->leftJoin('usuaris as comprador', 'comandes.idComprador', '=', 'comprador.idUsuari')
            ->select('venedor.nick AS nickVenedor', 'comprador.nick AS nickComprador','comandes.preuTotal AS total', 'comandes.estatComanda AS estat',
                'comandes.isEnviament AS isEnviament','comandes.idEnviament AS idEnviament','comandes.idComanda AS idComanda','comandes.idVenedor as idVenedor',
                'comandes.idComprador as idComprador','comandes.isEnviament as isEnviament')
            ->where('idVenedor', Auth::id())
            ->get();
        $titol="Les meves Vendes";
        return Inertia::render('llistaComandes', ['comandes' => $comandes, 'titol'=>$titol]);

    }



    public function agregarArticleComanda(Request $request)
    {
        //primer hem de comprobar si l'usuari te una comanda en estat en compra del mateix venedor
        $comanda = Comandes::where('idVenedor', $request->idVenedor)
            ->where('idComprador', Auth::id())
            ->where('EstatComanda', "En compra")
            ->first();


        if ($comanda) {
           //si existeix actualizem comanda amb noves dades
            $comanda->preuTotal+=($request->quantitatComprada*$request->preuArticle);
            $comanda->updated_at=Carbon::now()->format('Y-m-d H:i:s');
            $comanda->updated_by=Auth::id();
            $comanda->save();
        } else {
            // Crea una nueva comanda
            $comanda = new Comandes();
            $comanda->idVenedor = $request->idVenedor;
            $comanda->preuTotal=($request->quantitatComprada*$request->preuArticle);
            $comanda->idComprador = Auth::id();
            $comanda->updated_at = Carbon::now()->format('Y-m-d H:i:s');
            $comanda->EstatComanda = "En compra";
            $comanda->save();
        }
        // ara afegim quantitat a una nova linia pero hem de saber si creem una nova linia
        // o nomes afegim la quantitat
        $linia = Linies::where('idComanda', $comanda->idComanda)
            ->where('idArticle', $request->idArticle)
            ->first();
        if ($linia) {
            $linia->quantitat += $request->quantitatComprada;
            $linia->updated_by = Auth::id();
            $linia->updated_at = Carbon::now()->format('Y-m-d H:i:s');
            $linia->save();
        }else{
            $linia = new Linies();
            $linia->idComanda = $comanda->idComanda;
            $linia->quantitat = $request->quantitatComprada;
            $linia->idArticle = $request->idArticle;
            $linia->created_by = Auth::id();
            $linia->updated_by = Auth::id();
            $linia->updated_at = Carbon::now()->format('Y-m-d H:i:s');
            $linia->save();
        }

        //hem d'actualizar la quantitat d'article
        $article = Articles::find($request->idArticle);
        $article->quantitatDisponible-= $request->quantitatComprada;
        $article->updated_by = Auth::id();
        $article->updated_at = Carbon::now()->format('Y-m-d H:i:s');
        $article->save();

    }



    public function listComandesCompraUser()
    {
        $comandes = DB::table('comandes')
            ->leftJoin('linies', 'linies.idComanda', '=', 'comandes.idComanda')
            ->leftJoin('articles', 'articles.idArticle', '=', 'linies.idArticle')
            ->leftJoin('productes', 'productes.idProducte', '=', 'articles.idProducte')
            ->leftJoin('usuaris', 'usuaris.idUsuari', '=', 'comandes.idVenedor')
            ->where('comandes.idComprador',"=", Auth::id())
            ->where('comandes.EstatComanda',"=", "En compra")
            ->select(   'productes.nom as nomArticleComprat',
                                'articles.preuUnitari as preuArticleComprat',
                                'linies.quantitat as qtyComprada',
                                'usuaris.nick as nickVenedor',
                                'linies.idLinia as idLinia',
                                'comandes.idComanda as idComanda')
            ->orderBy("linies.updated_at")
            ->get();
        return response()->json($comandes);
    }
    public function confirmarCompra()
    {
        $comandes = Comandes::where('idComprador', Auth::id())
            ->where('EstatComanda', "En compra")
            ->get();
        foreach ( $comandes as $comanda) {
            $comanda->EstatComanda ="Pendent pagament";
            $comanda->save();
        }
    }

    public function buidarCompra()
    {
        $comandes = Comandes::where('idComprador', Auth::id())
            ->where('EstatComanda', "En compra")
            ->get();
        foreach ( $comandes as $comanda) {
            $linies = Linies::where('idComanda', $comanda->idComanda) ->get();
            foreach ( $linies as $linia) {
                $article = Articles::where('idArticle', $linia->idArticle)->first();
                $article->quantitatDisponible+=$linia->quantitat;
                $article->save();
                $linia->delete();
            }
            $comanda->delete();
            return redirect()->route('ListArticles');

        }
    }

    public function eliminarComanda(Request $request)
    {
        $comanda = Comandes::where('idComanda', $request->idComanda)->first();
        $linies = Linies::where('idComanda', $comanda->idComanda) ->get();
        foreach ( $linies as $linia) {
            $article = Articles::where('idArticle', $linia->idArticle)->first();
            $article->quantitatDisponible+=$linia->quantitat;
            $article->save();
            $linia->delete();
        }
        $comanda->delete();
    }
    public function confirmarPagament(Request $request)
    {
        $comanda = Comandes::where('idComanda', $request->idComanda)->first();
        //restamos y sumamos saldos
        $comprador = User::where('idUsuari', $comanda->idComprador)
            ->first();
        $comprador->saldo=$comprador->saldo- $request->totalFinal;
        $comprador->save();

        $venedor = User::where('idUsuari', $comanda->idVenedor)
            ->first();
        $venedor->saldo=$venedor->saldo+ $comanda->preuTotal;
        $venedor->save();

        $comanda->comisio=$request->comisio;
        $comanda->preuTotal=$request->totalFinal;
        if($request->isEnviament===true){
            $comanda->isEnviament=true;
            $comanda->EstatComanda="Pendent Enviament";
            $comanda->save();
            $enviament = new Enviaments();
            $enviament->idDesti=$request->idDireccio;
            $enviament->idTipusEnviament=$request->idTipusEnviament;
            $enviament->idComanda=$request->idComanda;
            $enviament->save();
        }else {
            $comanda->EstatComanda="Pendent preparacio";
            $comanda->save();
        }

    }

    public function confirmarNouEstat(Request $request)
    {
        $comanda = Comandes::where('idComanda', $request->idComanda)->first();
        $comanda->EstatComanda=$request->estat;
        $comanda->save();

    }

}
