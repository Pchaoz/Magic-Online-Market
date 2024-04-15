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
        Schema::dropIfExists('expansio_cartes');
    }
};
