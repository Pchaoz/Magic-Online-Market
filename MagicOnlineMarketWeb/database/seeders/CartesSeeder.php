<?php

namespace Database\Seeders;

use Carbon\Carbon;
use Illuminate\Database\Console\Seeds\WithoutModelEvents;
use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Schema;

class CartesSeeder extends Seeder
{

    public function run(): void
    {
        Schema::disableForeignKeyConstraints();
        DB::table('expansions')->insert([
            'nom' => 'Dominaria Unida',
            'dataSortida' =>  '2022-09-02',
            'created_at' => Carbon::now()->format('Y-m-d H:i:s'),
        ]);
        DB::table('expansions')->insert([
            'nom' => 'La Guerra de los Hermanos',
            'dataSortida' =>  '2022-11-11',
            'created_at' => Carbon::now()->format('Y-m-d H:i:s'),
        ]);
        DB::table('expansions')->insert([
            'nom' => 'Kamigawa:Dinastía de Neon',
            'dataSortida' =>  '2022-02-11',
            'created_at' => Carbon::now()->format('Y-m-d H:i:s'),
        ]);
        DB::table('expansions')->insert([
            'nom' => 'Strixhaven:Academia de Magos',
            'dataSortida' =>  '2021-04-16',
            'created_at' => Carbon::now()->format('Y-m-d H:i:s'),
        ]);
        DB::table('expansions')->insert([
            'nom' => 'La Guerra de la Chispa',
            'dataSortida' =>  '2019-04-27',
            'created_at' => Carbon::now()->format('Y-m-d H:i:s'),
        ]);
        DB::table('expansions')->insert([
            'nom' => 'Amonkhet',
            'dataSortida' =>  '2017-04-28',
            'created_at' => Carbon::now()->format('Y-m-d H:i:s'),
        ]);
        DB::table('expansions')->insert([
            'nom' => 'La Batalla por Zendikar',
            'dataSortida' =>  '2015-09-26',
            'created_at' => Carbon::now()->format('Y-m-d H:i:s'),
        ]);
        Schema::enableForeignKeyConstraints();
    }
}
