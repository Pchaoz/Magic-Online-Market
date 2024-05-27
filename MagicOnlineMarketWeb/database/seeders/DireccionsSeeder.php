<?php

namespace Database\Seeders;

use Carbon\Carbon;
use Illuminate\Database\Console\Seeds\WithoutModelEvents;
use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Schema;

class DireccionsSeeder extends Seeder
{

    public function run(): void
    {
        Schema::disableForeignKeyConstraints();
        DB::table('direccions')->insert([
            'direccio' => 'Gran via 85 7m-2n',
            'codiPostal' => '08001',
            'idCiutat'  => '1',
            'idPropietari'=>'1',
            'created_at' => Carbon::now()->format('Y-m-d H:i:s'),
            'updated_at' => Carbon::now()->format('Y-m-d H:i:s'),
        ]);
        DB::table('direccions')->insert([
            'direccio' => 'Carrer Garrigues 1-3 4t 3ra',
            'codiPostal' => '08207',
            'idCiutat'  => '10',
            'idPropietari'=>'2',
            'created_at' => Carbon::now()->format('Y-m-d H:i:s'),
            'updated_at' => Carbon::now()->format('Y-m-d H:i:s'),
        ]);
        DB::table('direccions')->insert([
            'direccio' => 'Mohrenstrasse 37',
            'codiPostal' => '10117 ',
            'idCiutat'  => '12',
            'idPropietari'=>'3',
            'created_at' => Carbon::now()->format('Y-m-d H:i:s'),
            'updated_at' => Carbon::now()->format('Y-m-d H:i:s'),
        ]);
        DB::table('direccions')->insert([
            'direccio' => 'Piazza di Spagna 14',
            'codiPostal' => '64700',
            'idCiutat'  => '7',
            'idPropietari'=>'1',
            'created_at' => Carbon::now()->format('Y-m-d H:i:s'),
            'updated_at' => Carbon::now()->format('Y-m-d H:i:s'),
        ]);
        DB::table('direccions')->insert([
            'direccio' => '​Rua do Salitre, 1',
            'codiPostal' => '1269-052',
            'idCiutat'  => '4',
            'idPropietari'=>'4',
            'created_at' => Carbon::now()->format('Y-m-d H:i:s'),
            'updated_at' => Carbon::now()->format('Y-m-d H:i:s'),
        ]);
        Schema::enableForeignKeyConstraints();
    }
}
