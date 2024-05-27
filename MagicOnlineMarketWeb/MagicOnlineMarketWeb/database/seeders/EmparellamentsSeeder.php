<?php

namespace Database\Seeders;

use Carbon\Carbon;
use Illuminate\Database\Console\Seeds\WithoutModelEvents;
use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Schema;

class EmparellamentsSeeder extends Seeder
{

    public function run(): void
    {

        Schema::disableForeignKeyConstraints();
        DB::table('emparellaments')->insert([
            'ronda' => 1,
            'idTorneig' => 1,
            'idParticipantA' => 2,
            'idParticipantB' => 3,
            'idResultat' => 2,
            'created_at' => Carbon::now()->format('Y-m-d H:i:s'),
            'updated_at' => Carbon::now()->format('Y-m-d H:i:s'),
        ]);
        DB::table('emparellaments')->insert([
            'ronda' => 10,
            'idTorneig' => 2,
            'idParticipantA' => 1,
            'idParticipantB' => 2,
            'idResultat' => 1,
            'created_at' => Carbon::now()->format('Y-m-d H:i:s'),
            'updated_at' => Carbon::now()->format('Y-m-d H:i:s'),
        ]);
        DB::table('emparellaments')->insert([
            'ronda' => 1,
            'idTorneig' => 3,
            'idParticipantA' => 3,
            'idParticipantB' => 4,
            'idResultat' => 2,
            'created_at' => Carbon::now()->format('Y-m-d H:i:s'),
            'updated_at' => Carbon::now()->format('Y-m-d H:i:s'),
        ]);
        Schema::enableForeignKeyConstraints();
    }
}
