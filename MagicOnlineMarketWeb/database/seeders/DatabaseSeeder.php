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
        $this->call([CartesSeeder::class]);
        $this->call([BarallaCartaSeeder::class]);
        $this->call([BarallesSeeder::class]);
        $this->call([CategoriaProductesSeeder::class]);
        $this->call([DireccionsSeeder::class]);
        $this->call([ProductesSeeder::class]);
        $this->call([ResultatSeeder::class]);
        $this->call([ArticlesSeeder::class]);
        $this->call([UsuariDireccioSeeder::class]);
        $this->call([TipusTorneigSeeder::class]);
        $this->call([TornejosSeeder::class]);
        $this->call([ComandesSeeder::class]);
        $this->call([LiniesSeeder::class]);
        $this->call([EnviamentsSeeder::class]);
        $this->call([TipusEnviamentsSeeder::class]);
        $this->call([TipusCartesSeeder::class]);
        $this->call([TipusCartesCartesSeeder::class]);
        $this->call([EmparellamentsSeeder::class]);
        $this->call([ParticipacionsSeeder::class]);
        $this->call([PremisSeeder::class]);
        $this->call([NoticiesSeeder::class]);




    }
}
