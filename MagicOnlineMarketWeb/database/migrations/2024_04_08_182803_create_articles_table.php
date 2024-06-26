<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{

    public function up(): void
    {

        Schema::create('articles', function (Blueprint $table) {
            $table->bigIncrements("idArticle");
            $table->integer("quantitatDisponible")->default(1);
            $table->double("preuUnitari");
            $table->foreignId("idProducte")->nullable()->constrained('productes')->references('idProducte');
            $table->foreignId("idVenedor")->nullable()->constrained('usuaris')->references('idUsuari');
            $table->foreignId('updated_by')->default(1)->constrained('usuaris')->references('idUsuari');
            $table->foreignId('created_by')->default(1)->constrained('usuaris')->references('idUsuari');
            $table->timestamps();
        });
    }


    public function down(): void
    {
        Schema::dropIfExists('ofertes');
    }
};
