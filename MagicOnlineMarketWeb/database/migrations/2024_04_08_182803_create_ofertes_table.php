<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{

    public function up(): void
    {
        Schema::create('ofertes', function (Blueprint $table) {
            $table->bigIncrements("idOferta");
            $table->integer("quantitat")->default(1);
            $table->foreignId("idProducte")->nullable()->constrained('productes')->references('idProducte');
            $table->foreignId("idVenedor")->nullable()->constrained('usuaris')->references('idUsuari');
            $table->foreignId('updated_by')->default(1)->constrained('usuaris')->references('idUsuari');
            $table->foreignId('created_by')->default(1)->constrained('usuaris')->references('idUsuari');
            $table->double("preu");
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('ofertes');
    }
};
