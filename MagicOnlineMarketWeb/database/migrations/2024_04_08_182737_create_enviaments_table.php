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
        Schema::create('enviaments', function (Blueprint $table) {

            $table->bigIncrements("idEnviament");
            $table->foreignId('idDesti')->nullable()->constrained('direccions')->references('idDireccio');
            $table->foreignId('idTipusEnviament')->nullable()->constrained('tipus_enviaments')->references('idTipusEnviament');
            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('enviaments');
    }
};
