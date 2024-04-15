<?php

namespace Database\Seeders;

use App\Models\Raresa;
use App\Models\User;
// use Illuminate\Database\Console\Seeds\WithoutModelEvents;
use Illuminate\Database\Seeder;

class DatabaseSeeder extends Seeder
{
    /**
     * Seed the application's database.
     */
    public function run(): void
    {

        $this->call([RolsSeeder::class]);
        $this->call([UsuariSeeder::class]);
        $this->call([PaissosSeeder::class]);
        $this->call([CiutatsSeeder::class]);
        $this->call([ExpansionsSeeder::class]);
        $this->call([RaresaSeeder::class]);
        $this->call([CartesSeeder::class]);
    }
}
