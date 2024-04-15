<?php

namespace Database\Seeders;

use Illuminate\Database\Console\Seeds\WithoutModelEvents;
use Illuminate\Database\Seeder;
use Illuminate\Support\Carbon;
use Illuminate\Support\Facades\DB;

class PaissosSeeder extends Seeder
{
    public function run(): void
    {
        DB::table('paissos')->insert([
            'nom' => 'Espanya',
            'created_at' => Carbon::now()->format('Y-m-d H:i:s'),
        ]);

        DB::table('paissos')->insert([
            'nom' => 'Portugal',
            'created_at' => Carbon::now()->format('Y-m-d H:i:s'),
        ]);

        DB::table('paissos')->insert([
            'nom' => 'Andorra',
            'created_at' => Carbon::now()->format('Y-m-d H:i:s'),
        ]);
        DB::table('paissos')->insert([
            'nom' => 'Italia',
            'created_at' => Carbon::now()->format('Y-m-d H:i:s'),
        ]);


        DB::table('paissos')->insert([
            'nom' => 'França',
            'created_at' => Carbon::now()->format('Y-m-d H:i:s'),
        ]);

        DB::table('paissos')->insert([
            'nom' => 'Alemania',
            'created_at' => Carbon::now()->format('Y-m-d H:i:s'),
        ]);

        DB::table('paissos')->insert([
            'nom' => 'Russia',
            'created_at' => Carbon::now()->format('Y-m-d H:i:s'),
        ]);
        DB::table('paissos')->insert([
            'nom' => 'Marroc',
            'created_at' => Carbon::now()->format('Y-m-d H:i:s'),
        ]);

    }
}
