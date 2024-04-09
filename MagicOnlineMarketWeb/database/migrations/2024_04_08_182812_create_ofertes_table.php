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
