<?php

namespace Database\Seeders;

use Carbon\Carbon;
use Illuminate\Database\Console\Seeds\WithoutModelEvents;
use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Schema;

class TipusEnviamentsSeeder extends Seeder
{

    public function run(): void
    {


        Schema::disableForeignKeyConstraints();
        DB::table('tipus_enviaments')->insert([
            'nom' => 'certificat',
            'preu' => '1.25',
            'created_at' => Carbon::now()->format('Y-m-d H:i:s'),
            'updated_at' => Carbon::now()->format('Y-m-d H:i:s'),
        ]);
        DB::table('tipus_enviaments')->insert([
            'nom' => 'ordinari',
            'preu' => '0.90',
            'created_at' => Carbon::now()->format('Y-m-d H:i:s'),
            'updated_at' => Carbon::now()->format('Y-m-d H:i:s'),
        ]);
        DB::table('tipus_enviaments')->insert([
            'nom' => 'certificat',
            'preu' => '5.35',
            'created_at' => Carbon::now()->format('Y-m-d H:i:s'),
            'updated_at' => Carbon::now()->format('Y-m-d H:i:s'),
        ]);
        Schema::enableForeignKeyConstraints();
    }
}
