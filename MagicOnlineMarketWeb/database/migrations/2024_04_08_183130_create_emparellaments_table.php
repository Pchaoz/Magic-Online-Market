<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{

    public function up(): void
    {
        Schema::disableForeignKeyConstraints();

        Schema::create('emparellaments', function (Blueprint $table) {
            $table->bigIncrements("idEmparellament");
            $table->integer("ronda");
            $table->foreignId('idTorneig')->constrained('tornejos')->references('idTorneig');
            $table->foreignId('idParticipantA')->constrained('participacions')->references('idParticipacio');
            $table->foreignId('idParticipantB')->constrained('participacions')->references('idParticipacio');
            $table->foreignId('idResultat')->constrained('resultats')->references('idResultat');
            $table->foreignId('updated_by')->default(1)->constrained('usuaris')->references('idUsuari');
            $table->foreignId('created_by')->default(1)->constrained('usuaris')->references('idUsuari');
            $table->timestamps();

        });
        Schema::enableForeignKeyConstraints();
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('emparellaments');
    }
};
