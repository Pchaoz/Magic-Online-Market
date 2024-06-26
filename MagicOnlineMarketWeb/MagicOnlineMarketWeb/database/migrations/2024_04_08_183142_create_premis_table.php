<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    protected $fillable = ["idPremi","posicio"];
    public function up(): void
    {
        Schema::create('premis', function (Blueprint $table) {
            $table->bigIncrements("idPremi");
            $table->integer("posicio")->default(1);
            $table->integer("quantitat")->default(1);
            $table->foreignId("idProducte")->constrained('productes')->references('idProducte');
            $table->foreignId("idTorneig")->constrained('tornejos')->references('idTorneig');
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
        Schema::dropIfExists('premis');
    }
};
