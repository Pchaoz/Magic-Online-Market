<?php

namespace App\Http\Controllers;

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
                    'tornejos.diaHoraInici as inici' )
            ->get();


        return Inertia::render('llistaTornejos',['tornejos'=>$tornejos]);

    }


}
