<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{

    public function up(): void
    {
        Schema::create('tornejos', function (Blueprint $table) {
            $table->bigIncrements("idTorneig");
            $table->integer("numparticipants")->default(2);
            $table->integer("minParticipants")->default(2);
            $table->integer("maxParticipants");
            $table->integer("numeroRondes")->default(1);
            $table->foreignId('idOrganitzador')->constrained('usuaris')->references('idUsuari');
            $table->foreignId('idTipusTorneig')->constrained('tipus_torneigs')->references('idTipusTorneig');
            $table->timestamp("horaInici");
            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('tornejos');
    }
};
