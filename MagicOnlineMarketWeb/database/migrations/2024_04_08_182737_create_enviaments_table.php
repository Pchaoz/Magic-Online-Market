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
        Schema::create('enviaments', function (Blueprint $table) {
            $table->bigIncrements("idEnviament");
            $table->foreignId('idDesti')->nullable()->constrained('direccions')->references('idDireccio');
            $table->foreignId('idTipusEnviament')->nullable()->constrained('tipus_enviaments')->references('idTipusEnviament');
            $table->foreignId('idComanda')->nullable()->constrained('comandes')->references('idComanda');
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
        Schema::dropIfExists('enviaments');
    }
};
