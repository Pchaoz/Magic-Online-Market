<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    /**
     * Run the migrations.
     */
    public function up(): void
    {
        Schema::disableForeignKeyConstraints();
        Schema::create('resultats', function (Blueprint $table) {
            $table->id();
            $table->integer("resultatJugadorA")->default(0);
            $table->integer("resultatJugadorB")->default(0);
            $table->foreignId('idEmparellament')->default(1)->constrained('emparellaments')->references('idEmparellament');
            $table->foreignId('updated_by')->default(1)->constrained('usuaris')->references('idUsuari');
            $table->foreignId('created_by')->default(1)->constrained('usuaris')->references('idUsuari');
            $table->timestamps();
        });
        Schema::enableForeignKeyConstraints();


    }

    public function down(): void
    {
        Schema::dropIfExists('resultats');
    }
};
