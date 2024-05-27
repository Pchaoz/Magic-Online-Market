<?php

namespace Database\Seeders;

use Carbon\Carbon;
use Illuminate\Database\Console\Seeds\WithoutModelEvents;
use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Schema;

class ProductesSeeder extends Seeder
{

    public function run(): void
    {

        Schema::disableForeignKeyConstraints();
        DB::table('productes')->insert([
            'nom' => 'Ulamog, El Hambre que no Cesa',
            'descripcio' => 'Cuando lances a Ulamog, el Hambre Que No Cesa, exilia dos permanentes objetivo.Indestructible.Siempre que Ulamog ataque, el jugador defensor exilia las veinte primeras cartas de su biblioteca.',
            'imatge'  => 'productes/ulamogHambre.jpg',
            'idCategoriaProducte'  => '1',
            'idExpansio'  => '7',
            'idCarta'  => '1',
            'created_at' => Carbon::now()->format('Y-m-d H:i:s'),
            'updated_at' => Carbon::now()->format('Y-m-d H:i:s'),
        ]);
        DB::table('productes')->insert([
            'nom' => 'Llanura',
            'descripcio' => '({T}: Add {W}.)',
            'imatge'  => 'productes/llanuraAmonkhet.jpg',
            'idCategoriaProducte'  => '1',
            'idExpansio'  => '6',
            'idCarta'  => '7',
            'created_at' => Carbon::now()->format('Y-m-d H:i:s'),
            'updated_at' => Carbon::now()->format('Y-m-d H:i:s'),
        ]);
        DB::table('productes')->insert([
            'nom' => 'Llanura',
            'descripcio' => '({T}: Add {W}.)',
            'imatge'  => 'productes/llanuraDominariaUnida.jpg',
            'idCategoriaProducte'  => '1',
            'idExpansio'  => '1',
            'idCarta'  => '7',
            'created_at' => Carbon::now()->format('Y-m-d H:i:s'),
            'updated_at' => Carbon::now()->format('Y-m-d H:i:s'),
        ]);
        DB::table('productes')->insert([
            'nom' => 'Llanura',
            'descripcio' => '({T}: Add {W}.)',
            'imatge'  => 'productes/llanuraGuerraHermanos.jpg',
            'idCategoriaProducte'  => '1',
            'idExpansio'  => '2',
            'idCarta'  => '7',
            'created_at' => Carbon::now()->format('Y-m-d H:i:s'),
            'updated_at' => Carbon::now()->format('Y-m-d H:i:s'),
        ]);
        DB::table('productes')->insert([
            'nom' => 'Caja sobres de Amonkhet',
            'descripcio' => 'Caja de 36 sobres',
            'imatge'  => 'productes/cajaAmonkhet.jpg',
            'idCategoriaProducte'  => '2',
            'idExpansio'  => '6',
            'created_at' => Carbon::now()->format('Y-m-d H:i:s'),
            'updated_at' => Carbon::now()->format('Y-m-d H:i:s'),
        ]);
        DB::table('productes')->insert([
            'nom' => 'Tapete Elesh Norn',
            'descripcio' => 'Tapete de 24*13.5 seriegrafiado',
            'imatge'  => 'productes/tapeteEleshNorn.jpg',
            'idCategoriaProducte'  => '4',
            'created_at' => Carbon::now()->format('Y-m-d H:i:s'),
            'updated_at' => Carbon::now()->format('Y-m-d H:i:s'),
        ]);

        Schema::enableForeignKeyConstraints();
    }
}
