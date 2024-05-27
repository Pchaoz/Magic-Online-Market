<?php

namespace Database\Seeders;

use Carbon\Carbon;
use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Schema;

class WishlistSeeder extends Seeder
{

    public function run(): void
    {
        Schema::disableForeignKeyConstraints();
        DB::table('wishlists')->insert([
            'nom' => 'Eldrazi Power Upgrade',
            'idPropietari'=> '1',
            'created_at' => Carbon::now()->format('Y-m-d H:i:s'),
            'updated_at' => Carbon::now()->format('Y-m-d H:i:s'),
        ]);
        DB::table('wishlists')->insert([
            'nom' => 'Compras tienda',
            'idPropietari'=> '5',
            'created_at' => Carbon::now()->format('Y-m-d H:i:s'),
            'updated_at' => Carbon::now()->format('Y-m-d H:i:s'),
        ]);
        DB::table('wishlists')->insert([
            'nom' => 'Pruebas Raúl',
            'idPropietari'=> '2',
            'created_at' => Carbon::now()->format('Y-m-d H:i:s'),
            'updated_at' => Carbon::now()->format('Y-m-d H:i:s'),
        ]);
        Schema::enableForeignKeyConstraints();

    }
}
