<?php

namespace Database\Seeders;

use Carbon\Carbon;
use Illuminate\Database\Console\Seeds\WithoutModelEvents;
use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\DB;

class UsuariSeeder extends Seeder
{

    public function run(): void
    {
        DB::table('usuaris')->insert([
            'nick' => 'admin',
            'name' => 'Administrador',
            'cognom'=> 'Admin',
            'email' => 'admin@gmail.com',
            'password' => '123456789',
            'saldo' => '100',
            'idRol'=>2,
            'created_at' => Carbon::now()->format('Y-m-d H:i:s'),
        ]);
        DB::table('usuaris')->insert([
            'nick' => 'makynilla',
            'name' => 'Raúl',
            'cognom'=> 'Martín-Caro Gómez',
            'email' => 'raul.martincaro@gmail.com',
            'password' => 'laravel123',
            'saldo' => '500',
            'idRol'=>2,
            'created_at' => Carbon::now()->format('Y-m-d H:i:s'),
        ]);

        DB::table('usuaris')->insert([
            'nick' => 'Pchaoz',
            'name' => 'Pol',
            'cognom' => 'Sotillos',
            'email' => 'p.sotillos@gmail.com',
            'password' => '123laravel',
            'created_at' => Carbon::now()->format('Y-m-d H:i:s'),
        ]);

    }
}
