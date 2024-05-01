<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{

    public function up(): void
    {

        Schema::disableForeignKeyConstraints();
        Schema::create('productes', function (Blueprint $table) {
            $table->bigIncrements("idProducte");
            $table->string("nom");
            $table->string("descripcio")->nullable();
            $table->string("imatge")->nullable();
            $table->foreignId("idCategoriaProducte")->nullable()->constrained('categoria_productes')->references('idCategoriaProductes');
            $table->foreignId("idExpansio")->nullable()->constrained('expansions')->references('idExpansio');
            $table->foreignId("idCarta")->nullable()->constrained('cartes')->references('idCarta');
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
        Schema::dropIfExists('productes');
    }
};
