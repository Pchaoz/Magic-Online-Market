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
        DB::table('cartes')->insert([
            'nom' => 'Ulamog, El Hambre que no Cesa',
            'descripcio' =>  'Cuando lances a Ulamog, el Hambre Que No Cesa, exilia dos permanentes objetivo.Indestructible.Siempre que Ulamog ataque, el jugador defensor exilia las veinte primeras cartas de su biblioteca.',
            'idRaresa'=> '4',
            'created_at' => Carbon::now()->format('Y-m-d H:i:s'),
            'updated_at' => Carbon::now()->format('Y-m-d H:i:s'),
        ]);
        DB::table('cartes')->insert([
            'nom' => 'Choque',
            'descripcio' =>  'El Choque hace 2 puntos de daño a cualquier objetivo.',
            'idRaresa'=> '1',
            'created_at' => Carbon::now()->format('Y-m-d H:i:s'),
            'updated_at' => Carbon::now()->format('Y-m-d H:i:s'),
        ]);
        DB::table('cartes')->insert([
            'nom' => 'Tejedora de armonía',
            'descripcio' =>  'Las otras criaturas encantamiento que controlas obtienen +1/+1. {G}, {T}: Copia la habilidad activada o disparada objetivo que controlas de una fuente encantamiento. Puedes elegir nuevos objetivos para la copia.',
            'idRaresa'=> '3',
            'created_at' => Carbon::now()->format('Y-m-d H:i:s'),
            'updated_at' => Carbon::now()->format('Y-m-d H:i:s'),
        ]);
        DB::table('cartes')->insert([
            'nom' => 'Coacción',
            'descripcio' =>  'El oponente objetivo muestra su mano. Tú eliges de ahí una carta que no sea tierra ni criatura. Ese jugador descarta esa carta.',
            'idRaresa'=> '1',
            'created_at' => Carbon::now()->format('Y-m-d H:i:s'),
            'updated_at' => Carbon::now()->format('Y-m-d H:i:s'),
        ]);
        DB::table('cartes')->insert([
            'nom' => 'Optar',
            'descripcio' =>  'Adivina 1. Roba una carta.',
            'idRaresa'=> '1',
            'created_at' => Carbon::now()->format('Y-m-d H:i:s'),
            'updated_at' => Carbon::now()->format('Y-m-d H:i:s'),
        ]);

        Schema::enableForeignKeyConstraints();
    }
}
