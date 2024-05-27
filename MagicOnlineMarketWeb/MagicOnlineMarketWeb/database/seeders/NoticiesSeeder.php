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
            'titol' => 'Ganador Torneo Standard',
            'subtitol'=>'Usando le maso de cascada Chiang Shen hizo un 5-0-0. ',
            'contingut' => 'El Ganador del último RPTQ celebrado en España ha sido el chino chiang Shen.
            Muchas felicidades para él',
            'imatge'=>'/noticies/karlov.jpg',
            'dataHoraPublicacio' => '2022-01-15 9:00:00',
            'idCreador' => '1',
            'created_at' => Carbon::now()->format('Y-m-d H:i:s'),
            'updated_at' => Carbon::now()->format('Y-m-d H:i:s'),

        ]);
        DB::table('noticies')->insert([
            'titol' => 'Se estrena la página Magic Online Market',
            'subtitol'=>'Tras 2 meses de desarrollo la aplicación Magic Online Market se pone en uso provocando una gran demanda de la misma. ',
            'contingut' => 'Página estrenada',
            'imatge'=>'/noticies/thunder.jpg',
            'dataHoraPublicacio' => '2024-06-01 17:00:00',
            'idCreador' => '1',
            'created_at' => Carbon::now()->format('Y-m-d H:i:s'),
            'updated_at' => Carbon::now()->format('Y-m-d H:i:s'),

        ]);
        DB::table('noticies')->insert([
            'titol' => 'Pol tira el servidor por vez número 50',
            'subtitol'=>'Fuentes Policiales confirman que Pol tiró el servidor 50 veces seguidas, se plantea prisión preventiva.',
            'contingut' => 'Tras 2 días sin incidencias Pol Sotillos vuelve a las andadas.
            Raúl desesperado ha perdido los cuatro pelos que le quedaban',
            'imatge'=>'/noticies/moderhorizons.jpg',
            'dataHoraPublicacio' => '2024-04-17 20:00:00',
            'idCreador' => '1',
            'created_at' => Carbon::now()->format('Y-m-d H:i:s'),
            'updated_at' => Carbon::now()->format('Y-m-d H:i:s'),

        ]);

        Schema::enableForeignKeyConstraints();
    }
}
