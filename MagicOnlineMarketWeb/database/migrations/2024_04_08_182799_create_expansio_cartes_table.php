<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    protected $fillable = ["idEexpansioCartes"];

    public function up(): void
    {
        Schema::create('expansio_cartes', function (Blueprint $table) {
            $table->bigIncrements("idExpansioCarta");
            $table->foreignId("idCarta")->nullable()->constrained('cartes')->references('idCarta');
            $table->foreignId("idExpansio")->nullable()->constrained('expansions')->references('idExpansio');
            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('expansio_cartes');
    }
};
