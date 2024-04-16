<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::disableForeignKeyConstraints();
        Schema::create('cartes', function (Blueprint $table) {
            $table->bigIncrements("idCarta");
            $table->string("nom");
            $table->string("descripcio",2000);
            $table->string("imatge")->nullable();
            $table->foreignId('idRaresa')->default(1)->constrained('rareses')->references('idRaresa');
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
        Schema::dropIfExists('cartes');
    }
};
