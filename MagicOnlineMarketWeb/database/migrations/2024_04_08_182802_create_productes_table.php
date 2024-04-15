<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{

    public function up(): void
    {
        Schema::create('productes', function (Blueprint $table) {
            $table->bigIncrements("idProducte");
            $table->string("nom");
            $table->foreignId("idCategoriaProducte")->default(1)->constrained('categoria_productes')->references('idCategoriaProductes');
            $table->foreignId("idExpansioCarta")->nullable()->constrained('expansio_cartes')->references('idExpansioCarta');
            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('productes');
    }
};
