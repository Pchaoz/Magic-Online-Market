<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    protected $fillable = ["idCiutat","nom"];
    public function up(): void
    {
        Schema::create('ciutats', function (Blueprint $table) {
            $table->bigIncrements("idCiutat");
            $table->string("nom",30);
            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('ciutats');
    }
};
