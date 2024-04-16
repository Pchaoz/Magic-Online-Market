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
            $table->string("descripcio")->nullable();
            $table->string("imatge")->nullable();
            $table->foreignId("idCategoriaProducte")->default(1)->constrained('categoria_productes')->references('idCategoriaProductes');
            $table->foreignId("idExpansioCarta")->nullable()->constrained('expansio_cartes')->references('idExpansioCarta');
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
        Schema::dropIfExists('productes');
    }
};
