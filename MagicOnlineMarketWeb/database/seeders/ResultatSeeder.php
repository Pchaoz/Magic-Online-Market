<?php

namespace Database\Seeders;

use Carbon\Carbon;
use Illuminate\Database\Console\Seeds\WithoutModelEvents;
use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Schema;

class ResultatSeeder extends Seeder
{

    public function run(): void
    {

        Schema::disableForeignKeyConstraints();
        DB::table('resultats')->insert([
            'resultatJugadorA' => 2,
            'resultatJugadorB' => 0,
            'idEmparellament'  => '1',
            'created_at' => Carbon::now()->format('Y-m-d H:i:s'),
            'updated_at' => Carbon::now()->format('Y-m-d H:i:s'),
        ]);
        DB::table('resultats')->insert([
            'resultatJugadorA' => 0,
            'resultatJugadorB' => 0,
            'idEmparellament'  => '2',
            'created_at' => Carbon::now()->format('Y-m-d H:i:s'),
            'updated_at' => Carbon::now()->format('Y-m-d H:i:s'),
        ]);
        DB::table('resultats')->insert([
            'resultatJugadorA' => 2,
            'resultatJugadorB' => 1,
            'idEmparellament'  => '3',
            'created_at' => Carbon::now()->format('Y-m-d H:i:s'),
            'updated_at' => Carbon::now()->format('Y-m-d H:i:s'),
        ]);
        DB::table('resultats')->insert([
            'resultatJugadorA' => 0,
            'resultatJugadorB' => 0,
            'idEmparellament'  => '4',
            'created_at' => Carbon::now()->format('Y-m-d H:i:s'),
            'updated_at' => Carbon::now()->format('Y-m-d H:i:s'),
        ]);
        DB::table('resultats')->insert([
            'resultatJugadorA' => 1,
            'resultatJugadorB' => 1,
            'idEmparellament'  => '5',
            'created_at' => Carbon::now()->format('Y-m-d H:i:s'),
            'updated_at' => Carbon::now()->format('Y-m-d H:i:s'),
        ]);




        Schema::enableForeignKeyConstraints();
    }
}
