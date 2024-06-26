<?php

namespace App\Http\Controllers;

use App\Models\Articles;
use Carbon\Carbon;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\DB;
use Inertia\Inertia;

class ArticleController extends Controller
{
    public function crearArticle(Request $request)
    {
        $article = new Articles();
        $article->idProducte = $request->idProducte;
        $article->quantitatDisponible = $request->quantitatDisponible;
        $article->preuUnitari = $request->preuUnitari;
        $article->updated_by = Auth::id();
        $article->created_by = Auth::id();
        $article->idVenedor = Auth::id();
        $article->save();
    }

    public function veureArticlesProducte($id)
    {
        $producte = DB::table('productes')
            ->leftJoin('categoria_productes', 'productes.idCategoriaProducte', '=', 'categoria_productes.idCategoriaProductes')
            ->leftJoin('expansions', 'productes.idExpansio', '=', 'expansions.idExpansio')
            ->select('productes.nom AS nom', 'productes.imatge AS imatge', 'categoria_productes.nom AS categoriaProducteNom',
                'expansions.nom AS expansioNom')
            ->where('productes.idProducte', '=', $id)
            ->get();
        $articles = DB::table('articles')
            ->leftJoin('usuaris', 'articles.idVenedor', '=', 'usuaris.idUsuari')
            ->leftJoin('productes', 'articles.idProducte', '=', 'productes.idProducte')
            ->select('usuaris.nick AS nick', 'articles.idVenedor AS idVenedor', 'articles.preuUnitari AS preu', 'articles.quantitatDisponible AS quantitat',
                'articles.idArticle AS idArticle','productes.nom as nom')
            ->where('articles.idProducte', '=', $id)
            ->where('articles.quantitatDisponible', '>', 0)
            ->get();
        return Inertia::render('OfertesArticle', ['producte' => $producte, 'articles' => $articles]);
    }


    public function ListArticles()
    {
        $articles = DB::table('articles')
            ->leftJoin('usuaris', 'articles.idVenedor', '=', 'usuaris.idUsuari')
            ->leftJoin('productes', 'articles.idProducte', '=', 'productes.idProducte')
            ->select('usuaris.nick AS nick', 'articles.idVenedor AS idVenedor', 'articles.preuUnitari AS preu', 'articles.quantitatDisponible AS quantitat',
                'articles.idArticle AS idArticle', 'productes.imatge as imatge', 'productes.nom as nom','articles.idProducte AS idProducte')
            ->where('articles.quantitatDisponible', '>', 0)
            ->orderBy('articles.preuUnitari', 'desc')
            ->get();

        return Inertia::render('llistaArticles', [ 'articles' => $articles]);
    }

    public function modificarArticle (Request $request)
    {

        $article= Articles::where('idArticle',$request->idArticle)->first();
        $article->quantitatDisponible = $request->quantitatDisponible;
        $article->preuUnitari = $request->preuUnitari;
        $article->updated_by = Auth::id();
        $article->updated_at = Carbon::now()->format('Y-m-d H:i:s');
        $article->save();
    }


    public function eliminarArticle(Request $request)
    {
        $article= Articles::where('idArticle',$request->idArticle)->first();
        $article->delete();
    }

    public function APIgetArticleById($id)
    {
        $articles = DB::table('articles')
            ->leftJoin('usuaris', 'articles.idVenedor', '=', 'usuaris.idUsuari')
            ->select('usuaris.nick AS nick', 'articles.idVenedor AS idVenedor', 'articles.preuUnitari AS preu', 'articles.quantitatDisponible AS quantitat',
                'articles.idArticle AS idArticle')
            ->where('articles.idProducte', '=', $id)
            ->get();

        return response()->json($articles);
    }

    public function  APIGetUserArticlesByID($id)
    {

        $articles = DB::table('articles')
            ->leftJoin('usuaris', 'articles.idVenedor', '=', 'usuaris.idUsuari')
            ->leftJoin('productes', 'articles.idProducte', '=', 'productes.idProducte')
            ->select('usuaris.nick AS nick', 'articles.idVenedor AS idVenedor', 'articles.preuUnitari AS preu', 'articles.quantitatDisponible AS quantitat',
                'articles.idArticle AS idArticle','productes.nom as nom', 'productes.idProducte AS idProducte')
            ->where('articles.idVenedor', '=', $id)
            ->where('articles.quantitatDisponible', '>', 0)
            ->orderBy('productes.idProducte')
            ->get();

        $producte = DB::table('productes')
            ->leftJoin('categoria_productes', 'productes.idCategoriaProducte', '=', 'categoria_productes.idCategoriaProductes')
            ->leftJoin('expansions', 'productes.idExpansio', '=', 'expansions.idExpansio')
            ->select('productes.nom AS nom', 'productes.imatge AS imatge', 'categoria_productes.nom AS categoriaProducteNom',
                'expansions.nom AS expansioNom', 'productes.idProducte AS idProducte')
            ->whereIn('productes.idProducte', $articles->pluck('idArticle')->toArray())
            ->orderBy('productes.idProducte')
            ->get();



        return response()->json(['producte' => $producte, 'articles' => $articles]);
    }

    public function APIuploadArticle(Request $request)
    {
        //return response()->json($request, 200);

        //SI FALLA LA ID DE USUARIO AVISAR PORQUE ESTO ME ESTA VOLVIENDO LOCO

        if ($request->idUser == 0) {
            return response()->json(['message' => "No s'ha carregat la informació del usuari correctament.."], 400);
        }

        $article = new Articles();
        $article->idProducte = $request->idProducte;
        $article->quantitatDisponible = $request->preuUnitari;
        $article->preuUnitari = doubleval( $request->quantitatDisponible );
        $article->updated_by = $request->idUser;
        $article->created_by = $request->idUser;
        $article->idVenedor = $request->idUser;
        $article->save();

        return response()->json(['message' => 'Artículo creado exitosamente'], 200);
    }

    public function APIgetLastOfertes()
    {
        $articles = DB::table('articles')
            ->leftJoin('usuaris', 'articles.idVenedor', '=', 'usuaris.idUsuari')
            ->leftJoin('productes', 'articles.idProducte', '=', 'productes.idProducte')
            ->select('usuaris.nick AS nick', 'articles.idVenedor AS idVenedor', 'articles.preuUnitari AS preu', 'articles.quantitatDisponible AS quantitat',
                'articles.idArticle AS idArticle', 'productes.imatge as imatge', 'productes.nom as nom','articles.idProducte AS idProducte','articles.updated_at')
            ->where('articles.quantitatDisponible', '>', 0)
            ->orderBy('articles.updated_at', 'desc')
            ->limit(5)
            ->get();

        return response()->json([$articles], 200);
    }
    public function updateArticleAPI (Request $request) {


        $article= Articles::where('idArticle',$request->idArticle)->first();
        $article->quantitatDisponible = $request->quantitatDisponible;
        $article->preuUnitari = $request->preuUnitari;
        $article->updated_by = $request->idUser;
        $article->updated_at = Carbon::now()->format('Y-m-d H:i:s');
        $article->save();

        return response()->json(['message' => 'Artículo actualizado exitosamente'], 200);
    }

    public function deleteArticleAPI(Request $request) {

        $article = DB::table('articles')->where('idArticle', '=', $request->query('idArticle'))->first();
        if ($article) {
            DB::table('articles')->where('idArticle', '=', $request->idArticle)->delete();
            return response()->json(['message' => 'Artículo eliminado exitosamente'], 200);
        } else {
            return response()->json(['message' => 'Artículo no encontrado'], 404);
        }
    }

}
