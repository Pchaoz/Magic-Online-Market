<?php

namespace App\Http\Controllers;


use App\Models\Noticies;
use Carbon\Carbon;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\DB;
use Inertia\Inertia;
use Illuminate\Http\Request;


class NoticiesController extends Controller
{
   public function listNoticies (){
       $noticies = DB::table('noticies')
           ->leftJoin('usuaris', 'noticies.idCreador', '=', 'usuaris.idUsuari')
           ->select('usuaris.nick AS nick', 'noticies.dataHoraPublicacio AS created', 'noticies.titol AS titol', 'noticies.idNoticia AS idNoticia')
           ->orderBy('noticies.dataHoraPublicacio','desc')
           ->get();

       return Inertia::render('llistaNoticies', ['noticies' => $noticies]);

   }


   public  function deleteNoticia (Request $request){

       $noticia= Noticies::find($request->idNoticia);
       $noticia->delete();
   }

    public function addNoticia(Request $request)
    {
        $noticia = new Noticies();
        $noticia->titol = $request->titol;
        $noticia->subtitol = $request->subtitol;
        $noticia->contingut = $request->contingut;
        if($request->hasFile('imatge')){
            $imageName = time().'.'.$request->imatge->extension();
            $request->imatge->move(public_path('images/noticies'), $imageName);
            $noticia->imatge = 'noticies/' . $imageName;
        }
        $noticia->updated_at = Carbon::now()->format('Y-m-d H:i:s');
        $noticia->idCreador =Auth::id();
        $noticia->created_by =Auth::id();
        $noticia->updated_by =Auth::id();
        $noticia->save();

    }


    public function seeNoticia($id){
        $noticia = DB::table('noticies')
            ->leftJoin('usuaris', 'noticies.idCreador','=','usuaris.idUsuari')
            ->select('usuaris.nick as nick','noticies.titol as titol','noticies.subtitol as subtitol',
                'noticies.contingut as contingut','noticies.imatge as imatge','noticies.dataHoraPublicacio as dataHora','noticies.idNoticia')
            ->where('noticies.idNoticia','=',$id)
            ->get();
        return Inertia::render('showNoticia', ['noticia' => $noticia]);
    }

    public function formModNoticia(Request $request)
    {

        $noticia = DB::table('noticies')
            ->select('noticies.titol as titol','noticies.subtitol as subtitol',
                'noticies.contingut as contingut','noticies.imatge as imatge','noticies.idNoticia')
            ->where('noticies.idNoticia','=',$request->idNoticia)
            ->first();

       return Inertia::render('formulariModificacioNoticia', ['noticia' => $noticia]);

    }

    public function modNoticia(Request $request)
    {

        $noticia = Noticies::where('idNoticia',$request->idNoticia)->first();
        $noticia->titol = $request->titol;
        $noticia->subtitol = $request->subtitol;
        $noticia->contingut = $request->contingut;
        if($request->hasFile('imatge')){
            $imageName = time().'.'.$request->imatge->extension();
            $request->imatge->move(public_path('images/noticies'), $imageName);
            $noticia->imatge = '/noticies/' . $imageName;
        }
        $noticia->updated_at = Carbon::now()->format('Y-m-d H:i:s');
        $noticia->updated_by =Auth::id();
        $noticia->save();
    }

    public function getNoticiaByIdAPI($id) {
        $noticia = DB::table('noticies')
            ->leftJoin('usuaris', 'noticies.idCreador','=','usuaris.idUsuari')
            ->select('usuaris.nick as nick','noticies.titol as titol','noticies.subtitol as subtitol',
                'noticies.contingut as contingut','noticies.imatge as imatge','noticies.dataHoraPublicacio as dataHora','noticies.idNoticia')
            ->where('noticies.idNoticia','=',$id)
            ->get();

        return response()->json($noticia);
    }

    public function getNoticiesAPI() {

        $noticies = DB::table('noticies')
        ->leftJoin('usuaris', 'noticies.idCreador', '=', 'usuaris.idUsuari')
        ->select('usuaris.nick AS nick', 'noticies.dataHoraPublicacio AS created','noticies.imatge as imatge', 'noticies.titol AS titol', 'noticies.idNoticia AS idNoticia')
        ->get();

        return response()->json($noticies);
    }

    public function getLastNews() {
        $noticies = DB::table('noticies')
        ->leftJoin('usuaris', 'noticies.idCreador', '=', 'usuaris.idUsuari')
        ->select('usuaris.nick AS nick', 'noticies.dataHoraPublicacio AS created','noticies.imatge as imatge', 'noticies.titol AS titol', 'noticies.idNoticia AS idNoticia')
        ->orderBy('created', 'asc')
        ->limit(3)
        ->get();

        return response()->json($noticies);
    }

}
