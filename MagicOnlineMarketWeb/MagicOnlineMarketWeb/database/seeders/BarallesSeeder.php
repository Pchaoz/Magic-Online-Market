<?php

namespace Database\Seeders;

use Carbon\Carbon;
use Illuminate\Database\Console\Seeds\WithoutModelEvents;
use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Schema;

class BarallesSeeder extends Seeder
{
    public function run(): void
    {
        Schema::disableForeignKeyConstraints();
        DB::table('baralles')->insert([
            'nom' => 'Eldrazi Power',
            'isPublic' => true,
            'idCreador'=> '2',
            'created_at' => Carbon::now()->format('Y-m-d H:i:s'),
            'updated_at' => Carbon::now()->format('Y-m-d H:i:s'),
        ]);
        DB::table('baralles')->insert([
            'nom' => 'Mono Blue Tempo',
            'idCreador'=> '3',
            'created_at' => Carbon::now()->format('Y-m-d H:i:s'),
            'updated_at' => Carbon::now()->format('Y-m-d H:i:s'),
        ]);
        DB::table('baralles')->insert([
            'nom' => 'Mono red Agro',
            'isPublic' => true,
            'idCreador'=> '4',
            'created_at' => Carbon::now()->format('Y-m-d H:i:s'),
            'updated_at' => Carbon::now()->format('Y-m-d H:i:s'),
        ]);
        DB::table('baralles')->insert([
            'nom' => 'Admin Final Power',
            'isPublic' => true,
            'idCreador'=> '1',
            'created_at' => Carbon::now()->format('Y-m-d H:i:s'),
            'updated_at' => Carbon::now()->format('Y-m-d H:i:s'),
        ]);
        DB::table('baralles')->insert([
            'nom' => 'Rakdos Midrange',
            'idCreador'=> '2',
            'created_at' => Carbon::now()->format('Y-m-d H:i:s'),
            'updated_at' => Carbon::now()->format('Y-m-d H:i:s'),
        ]);
        Schema::enableForeignKeyConstraints();



    }
}
