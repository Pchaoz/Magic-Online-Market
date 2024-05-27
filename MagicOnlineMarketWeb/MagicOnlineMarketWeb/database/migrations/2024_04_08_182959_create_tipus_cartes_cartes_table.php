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
            $table->foreignId("idCarta")->constrained('cartes')->references('idCarta')->onDelete('cascade');
            $table->foreignId("idTipusCarta")->constrained('tipus_cartes')->references('idTipusCarta');
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
        Schema::dropIfExists('tipus_cartes_cartes');
    }
};
