<?php

namespace Database\Seeders;

use Carbon\Carbon;
use Illuminate\Database\Console\Seeds\WithoutModelEvents;
use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Hash;
use Illuminate\Support\Facades\Schema;

class UsuariSeeder extends Seeder
{

    public function run(): void
    {
        Schema::disableForeignKeyConstraints();

        DB::table('usuaris')->insert([
            'nick' => 'admin',
            'name' => 'admin',
            'cognom'=> 'Admin',
            'email' => 'admin@gmail.com',
            'password' => Hash::make('123456789'),
            'saldo' => '100',
            'idRol'=>2,
            'created_at' => Carbon::now()->format('Y-m-d H:i:s'),
            'updated_at' => Carbon::now()->format('Y-m-d H:i:s'),
        ]);
        DB::table('usuaris')->insert([
            'nick' => 'makynilla',
            'name' => 'Raúl',
            'cognom'=> 'Martín-Caro Gómez',
            'email' => 'raul.martincaro@gmail.com',
            'password' => Hash::make('laravel123'),
            'saldo' => '500',
            'idRol'=>2,
            'created_at' => Carbon::now()->format('Y-m-d H:i:s'),
            'updated_at' => Carbon::now()->format('Y-m-d H:i:s'),
        ]);

        DB::table('usuaris')->insert([
            'nick' => 'Pchaoz',
            'name' => 'Pol',
            'cognom' => 'Sotillos',
            'email' => 'p.sotillos@gmail.com',
            'password' => Hash::make('123laravel'),
            'created_at' => Carbon::now()->format('Y-m-d H:i:s'),
            'updated_at' => Carbon::now()->format('Y-m-d H:i:s'),
        ]);

        DB::table('usuaris')->insert([
            'nick' => 'Agyko',
            'name' => 'Judith',
            'cognom' => 'Berron',
            'email' => 'agyko@gmail.com',
            'password' => Hash::make('-09112024-'),
            'created_at' => Carbon::now()->format('Y-m-d H:i:s'),
            'updated_at' => Carbon::now()->format('Y-m-d H:i:s'),
        ]);
        Schema::enableForeignKeyConstraints();

    }
}
