<?php

namespace Database\Seeders;

use Carbon\Carbon;
use Illuminate\Database\Console\Seeds\WithoutModelEvents;
use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Schema;

class ParticipacionsSeeder extends Seeder
{

    public function run(): void
    {

        Schema::create('participacions', function (Blueprint $table) {
            $table->bigIncrements("idParticipacio");
            $table->integer("puntuacio")->default(0);
            $table->foreignId("idUsuari")->constrained('usuaris')->references('idUsuari');
            $table->foreignId("idTorneig")->constrained('tornejos')->references('idTorneig');
            $table->foreignId('updated_by')->default(1)->constrained('usuaris')->references('idUsuari');
            $table->foreignId('created_by')->default(1)->constrained('usuaris')->references('idUsuari');
            $table->timestamps();
        Schema::disableForeignKeyConstraints();
        DB::table('emparellaments')->insert([
            'ronda'  => 26,
            'minParticipants'  => 12,
            'maxParticipants'  => 52,
            'numeroRondes'  => 10,
            'idOrganitzador'  => '1',
            'idTipusTorneig'  => '1',
            'diaHoraInici'  => '2024-04-16 9:00:00',
            'created_at' => Carbon::now()->format('Y-m-d H:i:s'),
            'updated_at' => Carbon::now()->format('Y-m-d H:i:s'),
        ]);

        Schema::enableForeignKeyConstraints();
    }
}
