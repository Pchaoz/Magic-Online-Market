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
            $table->string("resultat",10);
            $table->foreignId('idRonda')->constrained('rondes')->references('idRonda');
            $table->foreignId('idParticipantA')->constrained('participants')->references('idParticipant');
            $table->foreignId('idParticipantB')->constrained('participants')->references('idParticipant');
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
