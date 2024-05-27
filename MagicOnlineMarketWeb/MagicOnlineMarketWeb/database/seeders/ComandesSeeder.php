<?php

namespace Database\Seeders;

use Carbon\Carbon;
use Illuminate\Database\Console\Seeds\WithoutModelEvents;
use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Schema;

class ComandesSeeder extends Seeder
{
    public function run(): void
    {
        Schema::disableForeignKeyConstraints();
        DB::table('comandes')->insert([
            'isEnviament' => true,
            'EstatComanda' => 'Enviada',
            'idEnviament' => '1',
            'idComprador' => '3',
            'preuTotal'=> 200,
            'created_at' => Carbon::now()->format('Y-m-d H:i:s'),
            'updated_at' => Carbon::now()->format('Y-m-d H:i:s'),
        ]);
        DB::table('comandes')->insert([
            'isEnviament' => false,
            'EstatComanda' => 'Pendent recollida',
            'idComprador' => '2',
            'preuTotal'=> 20.25,
            'created_at' => Carbon::now()->format('Y-m-d H:i:s'),
            'updated_at' => Carbon::now()->format('Y-m-d H:i:s'),
        ]);
        DB::table('comandes')->insert([
            'isEnviament' => true,
            'EstatComanda' => 'Pagada',
            'idEnviament' => '2',
            'idComprador' => '4',
            'preuTotal'=> 1.75,
            'created_at' => Carbon::now()->format('Y-m-d H:i:s'),
            'updated_at' => Carbon::now()->format('Y-m-d H:i:s'),
        ]);
        DB::table('comandes')->insert([
            'isEnviament' => true,
            'EstatComanda' => 'Anulada',
            'idEnviament' => '3',
            'idComprador' => '1',
            'preuTotal'=> 15.69,
            'created_at' => Carbon::now()->format('Y-m-d H:i:s'),
            'updated_at' => Carbon::now()->format('Y-m-d H:i:s'),
        ]);

        Schema::enableForeignKeyConstraints();
    }
}
