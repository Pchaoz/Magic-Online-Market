<?php

namespace Database\Seeders;

use Carbon\Carbon;
use Illuminate\Database\Console\Seeds\WithoutModelEvents;
use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Schema;

class TipusTorneigSeeder extends Seeder
{

    public function run(): void
    {

        Schema::disableForeignKeyConstraints();
        DB::table('tipus_torneigs')->insert([
            'descripcio'  => 'Torneig standard eliminatori.',
            'created_at' => Carbon::now()->format('Y-m-d H:i:s'),
            'updated_at' => Carbon::now()->format('Y-m-d H:i:s'),
        ]);
        DB::table('tipus_torneigs')->insert([
            'descripcio'  => 'Torneig standard suiz',
            'created_at' => Carbon::now()->format('Y-m-d H:i:s'),
            'updated_at' => Carbon::now()->format('Y-m-d H:i:s'),
        ]);
        DB::table('tipus_torneigs')->insert([
            'descripcio'  => 'Gigante dos Cabezas standard',
            'created_at' => Carbon::now()->format('Y-m-d H:i:s'),
            'updated_at' => Carbon::now()->format('Y-m-d H:i:s'),
        ]);
        DB::table('tipus_torneigs')->insert([
            'descripcio'  => 'Legacy',
            'created_at' => Carbon::now()->format('Y-m-d H:i:s'),
            'updated_at' => Carbon::now()->format('Y-m-d H:i:s'),
        ]);
        Schema::enableForeignKeyConstraints();
    }
}
