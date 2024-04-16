<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{

    public function up(): void
    {
        Schema::create('emparellaments', function (Blueprint $table) {
            $table->bigIncrements("idEmparellament");
            $table->integer("ronda");
            $table->string("resultat",10);
            $table->foreignId('idTorneig')->constrained('tornejos')->references('idTorneig');
            $table->foreignId('idParticipantA')->constrained('participacions')->references('idParticipacio');
            $table->foreignId('idParticipantB')->constrained('participacions')->references('idParticipacio');
            $table->foreignId('updated_by')->default(1)->constrained('usuaris')->references('idUsuari');
            $table->foreignId('created_by')->default(1)->constrained('usuaris')->references('idUsuari');
            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('emparellaments');
    }
};
