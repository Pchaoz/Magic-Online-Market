<?php

namespace App\Http\Controllers;

use App\Models\Participacions;
use App\Models\Premis;
use App\Models\Tornejos;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\DB;
use Inertia\Inertia;

class TornejosController extends Controller
{

    public function ListTornejos()
    {
        $tornejos = DB::table('tornejos')
            ->leftJoin('usuaris as organitzador', 'tornejos.idOrganitzador', '=', 'organitzador.idUsuari')
            ->leftJoin('tipus_torneig as tipus', 'tornejos.idTipusTorneig', '=', 'tipus.idTipusTorneig')
            ->select('tornejos.numParticipants AS num', 'tornejos.maxParticipants AS max', 'tornejos.minParticipants AS min',
                'organitzador.nick as  nick','tipus.descripcio as descripcio','tornejos.numeroRondes as rondes','tornejos.estat as estat',
                    'tornejos.diaHoraInici as inici','tornejos.nom as nomTorneig', 'tornejos.idTorneig as idTorneig','tipus.idTipusTorneig as idTipusTorneig' )
            ->get();

        $tipusTornejos = DB::table('tipus_torneig')
            ->select('tipus_torneig.descripcio as descripcio','tipus_torneig.idTipusTorneig as idTipus')
            ->get();


        return Inertia::render('llistaTornejos',['tornejos'=>$tornejos,'tipusTornejos'=>$tipusTornejos]);

    }

    public function crearTorneig (Request $request){

        $torneig = new Tornejos();
        $torneig->nom = $request->nom;
        $torneig->numparticipants= $request->max;
        $torneig->maxparticipants = $request->min;
        $torneig->diaHoraInici =  $request->dataHoraInici;
        $torneig->idOrganitzador = Auth::id();
        $torneig->idTipusTorneig =$request->idTipus;
        $torneig->created_by =Auth::id();
        $torneig->updated_by =Auth::id();
        $torneig->save();

    }

    public function modificarTorneig (Request $request){
        $torneig= Tornejos::where('idTorneig',$request->idTorneig)->first();
        $torneig->nom = $request->nom;
        $torneig->numparticipants= $request->max;
        $torneig->maxparticipants = $request->min;
        $torneig->diaHoraInici =  $request->dataHoraInici;
        $torneig->idTipusTorneig =$request->idTipus;
        $torneig->updated_by =Auth::id();
        $torneig->save();
    }
    public function eliminarTorneig (Request $request){
        $torneig= Tornejos::where('idTorneig',$request->idTorneig)->first();
        $participants = Participacions::where('idTorneig',$torneig->idTorneig)->get();
        foreach ( $participants as $participant) {
            $participant->delete();
        }
        $premis = Premis::where('idTorneig',$torneig->idTorneig)->get();
        foreach ( $premis as $premi) {
            $premi->delete();
        }
        $torneig->delete();
    }






}
