<?php

namespace Database\Seeders;

use Carbon\Carbon;
use Illuminate\Database\Console\Seeds\WithoutModelEvents;
use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Schema;

class PremisSeeder extends Seeder
{
    public function run(): void
    {
        Schema::disableForeignKeyConstraints();
        DB::table('premis')->insert([
            'posicio' => '1',
            'quantitat' => '2',
            'idProducte' => '1',
            'idTorneig' => '1',
            'created_at' => Carbon::now()->format('Y-m-d H:i:s'),
            'updated_at' => Carbon::now()->format('Y-m-d H:i:s'),

        ]);
        DB::table('premis')->insert([
            'posicio' => '2',
            'quantitat' => '1',
            'idProducte' => '2',
            'idTorneig' => '1',
            'created_at' => Carbon::now()->format('Y-m-d H:i:s'),
            'updated_at' => Carbon::now()->format('Y-m-d H:i:s'),

        ]);
        DB::table('premis')->insert([
            'posicio' => '2',
            'quantitat' => '1',
            'idProducte' => '4',
            'idTorneig' => '1',
            'created_at' => Carbon::now()->format('Y-m-d H:i:s'),
            'updated_at' => Carbon::now()->format('Y-m-d H:i:s'),

        ]);
        DB::table('premis')->insert([
            'posicio' => '1',
            'quantitat' => '2',
            'idProducte' => '5',
            'idTorneig' => '3',
            'created_at' => Carbon::now()->format('Y-m-d H:i:s'),
            'updated_at' => Carbon::now()->format('Y-m-d H:i:s'),

        ]);
        Schema::enableForeignKeyConstraints();
    }
}
