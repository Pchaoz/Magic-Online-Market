<?php

namespace Database\Seeders;

use Carbon\Carbon;
use Illuminate\Database\Console\Seeds\WithoutModelEvents;
use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Schema;

class NoticiesSeeder extends Seeder
{

    public function run(): void
    {

        Schema::disableForeignKeyConstraints();
        DB::table('noticies')->insert([
            'títol' => 'Ganador Torneo Standard',
            'contingut' => 'El Ganador del último RPTQ celebrado en España ha sido el chino chiang Shen.
            Muchas felicidades para él',
            'dataHoraPublicacio' => '2022-01-15 9:00:00',
            'idCreador' => '1',
            'created_at' => Carbon::now()->format('Y-m-d H:i:s'),
            'updated_at' => Carbon::now()->format('Y-m-d H:i:s'),

        ]);
        DB::table('noticies')->insert([
            'títol' => 'Se estrena la página Magic Online Market',
            'contingut' => 'Página estrenada',
            'dataHoraPublicacio' => '2024-06-01 17:00:00',
            'idCreador' => '1',
            'created_at' => Carbon::now()->format('Y-m-d H:i:s'),
            'updated_at' => Carbon::now()->format('Y-m-d H:i:s'),

        ]);
        DB::table('noticies')->insert([
            'títol' => 'Pol tira el servidor por vez número 50',
            'contingut' => 'Tras 2 días sin incidencias Pol Sotillos vuelve a las andadas.
            Raúl desesperado ha perdido los cuatro pelos que le quedaban',
            'dataHoraPublicacio' => '2024-04-17 20:00:00',
            'idCreador' => '1',
            'created_at' => Carbon::now()->format('Y-m-d H:i:s'),
            'updated_at' => Carbon::now()->format('Y-m-d H:i:s'),

        ]);

        Schema::enableForeignKeyConstraints();
    }
}
