<?php

namespace Database\Seeders;

use Carbon\Carbon;
use Illuminate\Database\Console\Seeds\WithoutModelEvents;
use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Schema;

class ArticlesSeeder extends Seeder
{

    public function run(): void
    {
        Schema::disableForeignKeyConstraints();
        DB::table('articles')->insert([
            'quantitatDisponible' => 2,
            'preuUnitari' => 20.5,
            'idProducte'  => '1',
            'idVenedor'  => '1',
            'created_at' => Carbon::now()->format('Y-m-d H:i:s'),
            'updated_at' => Carbon::now()->format('Y-m-d H:i:s'),
        ]);
        DB::table('articles')->insert([
            'quantitatDisponible' => 10,
            'preuUnitari' => 56.95,
            'idProducte'  => '6',
            'idVenedor'  => '5',
            'created_at' => Carbon::now()->format('Y-m-d H:i:s'),
            'updated_at' => Carbon::now()->format('Y-m-d H:i:s'),
        ]);
        DB::table('articles')->insert([
            'quantitatDisponible' => 36,
            'preuUnitari' => 22.56,
            'idProducte'  => '6',
            'idVenedor'  => '5',
            'created_at' => Carbon::now()->format('Y-m-d H:i:s'),
            'updated_at' => Carbon::now()->format('Y-m-d H:i:s'),
        ]);
        DB::table('articles')->insert([
            'quantitatDisponible' => 100,
            'preuUnitari' => 0.15,
            'idProducte'  => '2',
            'idVenedor'  => '1',
            'created_at' => Carbon::now()->format('Y-m-d H:i:s'),
            'updated_at' => Carbon::now()->format('Y-m-d H:i:s'),
        ]);
        DB::table('articles')->insert([
            'quantitatDisponible' => 300,
            'preuUnitari' => 0.10,
            'idProducte'  => '3',
            'idVenedor'  => '1',
            'created_at' => Carbon::now()->format('Y-m-d H:i:s'),
            'updated_at' => Carbon::now()->format('Y-m-d H:i:s'),
        ]);


        Schema::enableForeignKeyConstraints();
    }
}
