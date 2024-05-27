<?php

namespace Database\Seeders;

use Carbon\Carbon;
use Illuminate\Database\Console\Seeds\WithoutModelEvents;
use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Schema;

class BarallaCartaSeeder extends Seeder
{

    public function run(): void
    {
        Schema::disableForeignKeyConstraints();
        DB::table('baralla_cartes')->insert([
            'quantitat' => 4,
            'idCarta' =>  '1',
            'idBaralla'=> '1',
            'created_at' => Carbon::now()->format('Y-m-d H:i:s'),
            'updated_at' => Carbon::now()->format('Y-m-d H:i:s'),
        ]);
        DB::table('baralla_cartes')->insert([
            'quantitat' => 10,
            'idCarta' =>  '11',
            'idBaralla'=> '1',
            'created_at' => Carbon::now()->format('Y-m-d H:i:s'),
            'updated_at' => Carbon::now()->format('Y-m-d H:i:s'),
        ]);
        DB::table('baralla_cartes')->insert([
            'quantitat' => 3,
            'idCarta' =>  '14',
            'idBaralla'=> '1',
            'created_at' => Carbon::now()->format('Y-m-d H:i:s'),
            'updated_at' => Carbon::now()->format('Y-m-d H:i:s'),
        ]);
        DB::table('baralla_cartes')->insert([
            'quantitat' => 10,
            'idCarta' =>  '8',
            'idBaralla'=> '2',
            'created_at' => Carbon::now()->format('Y-m-d H:i:s'),
            'updated_at' => Carbon::now()->format('Y-m-d H:i:s'),
        ]);
        DB::table('baralla_cartes')->insert([
            'quantitat' => 3,
            'idCarta' =>  '18',
            'idBaralla'=> '2',
            'created_at' => Carbon::now()->format('Y-m-d H:i:s'),
            'updated_at' => Carbon::now()->format('Y-m-d H:i:s'),
        ]);
        DB::table('baralla_cartes')->insert([
            'quantitat' => 2,
            'idCarta' =>  '5',
            'idBaralla'=> '2',
            'created_at' => Carbon::now()->format('Y-m-d H:i:s'),
            'updated_at' => Carbon::now()->format('Y-m-d H:i:s'),
        ]);
        DB::table('baralla_cartes')->insert([
            'quantitat' => 10,
            'idCarta' =>  '7',
            'idBaralla'=> '2',
            'created_at' => Carbon::now()->format('Y-m-d H:i:s'),
            'updated_at' => Carbon::now()->format('Y-m-d H:i:s'),
        ]);
        Schema::enableForeignKeyConstraints();

    }
}
