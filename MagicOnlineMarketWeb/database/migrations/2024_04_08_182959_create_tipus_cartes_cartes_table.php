<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{

    public function up(): void
    {
        Schema::create('tipus_cartes_cartes', function (Blueprint $table) {
            $table->bigIncrements("idTipusCartaCarta");
            $table->foreignId("idCarta")->constrained('cartes')->references('idCarta');
            $table->foreignId("idTipusCarta")->constrained('tipus_cartes')->references('idTipusCarta');
            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('tipus_cartes_cartes');
    }
};
