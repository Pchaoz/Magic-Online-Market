<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::create('linies', function (Blueprint $table) {
            $table->bigIncrements("idLinia");
            $table->integer("quantitat")->default(1);
            $table->double("preuUnitari");
            $table->double("total");
            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('linies');
    }
};
