<?php

namespace Database\Seeders;

use Carbon\Carbon;
use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Schema;

class TornejosSeeder extends Seeder
{

    public function run(): void
    {
        Schema::disableForeignKeyConstraints();
        DB::table('tornejos')->insert([
            'numparticipants'  => 26,
            'minParticipants'  => 12,
            'maxParticipants'  => 52,
            'numeroRondes'  => 10,
            'idOrganitzador'  => '1',
            'idTipusTorneig'  => '1',
            'estat'=> 'Acabat',
            'diaHoraInici'  => '2024-04-16 9:00:00',
            'created_at' => Carbon::now()->format('Y-m-d H:i:s'),
            'updated_at' => Carbon::now()->format('Y-m-d H:i:s'),
        ]);
        DB::table('tornejos')->insert([
            'maxParticipants'  => 120,
            'numeroRondes'  => 60,
            'idOrganitzador'  => '3',
            'idTipusTorneig'  => '1',
            'estat'=> 'Jugant',
            'diaHoraInici'  => '2024-08-31 00:00:00',
            'created_at' => Carbon::now()->format('Y-m-d H:i:s'),
            'updated_at' => Carbon::now()->format('Y-m-d H:i:s'),
        ]);
        DB::table('tornejos')->insert([
            'numparticipants'  => 12,
            'numeroRondes'  => 2,
            'idOrganitzador'  => '2',
            'idTipusTorneig'  => '1',
            'estat'=> 'En inscripció',
            'diaHoraInici'  => '2024-04-16 9:00:00',
            'created_at' => Carbon::now()->format('Y-m-d H:i:s'),
            'updated_at' => Carbon::now()->format('Y-m-d H:i:s'),
        ]);
        Schema::enableForeignKeyConstraints();
    }
}
