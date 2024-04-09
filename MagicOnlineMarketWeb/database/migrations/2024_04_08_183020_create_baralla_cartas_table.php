<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    protected $fillable = ["idBarallaCarta","quantitat"];

    public function up(): void
    {
        Schema::create('baralla_cartas', function (Blueprint $table) {
            $table->bigIncrements("idBarallaCarta");
            $table->integer("quantitat")->default(1);
            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('baralla_cartas');
    }
};
