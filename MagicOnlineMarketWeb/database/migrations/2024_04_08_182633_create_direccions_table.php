<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    protected $fillable = ["idDireccio","direccio","codiPostal"];
    public function up(): void
    {
        Schema::create('direccions', function (Blueprint $table) {
            $table->bigIncrements("idDireccio");
            $table->string("direccio",50);
            $table->string("codiPostal",20);
            $table->foreignId('idCiutat')->nullable()->constrained('ciutats')->references('idCiutat');
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
        Schema::dropIfExists('direccions');
    }
};
