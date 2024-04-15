<?php

namespace Database\Seeders;

use Carbon\Carbon;
use Illuminate\Database\Console\Seeds\WithoutModelEvents;
use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\DB;

class RolsSeeder extends Seeder
{
    public function run(): void
    {
        DB::table('rols')->insert([
            'nom' => 'administrador',
            'created_at' => Carbon::now()->format('Y-m-d H:i:s'),
        ]);

        DB::table('rols')->insert([
            'nom' => 'venedor',
            'created_at' => Carbon::now()->format('Y-m-d H:i:s'),
        ]);

        DB::table('rols')->insert([
            'nom' => 'venedor_premium',
            'created_at' => Carbon::now()->format('Y-m-d H:i:s'),
        ]);
        DB::table('rols')->insert([
            'nom' => 'usuari_ban',
            'created_at' => Carbon::now()->format('Y-m-d H:i:s'),
        ]);

    }
}
