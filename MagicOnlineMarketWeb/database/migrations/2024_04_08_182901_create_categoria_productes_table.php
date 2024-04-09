<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    protected $fillable = ["idCategoriesProductes","nom"];
    public function up(): void
    {
        Schema::create('categoria_productes', function (Blueprint $table) {
            $table->bigIncrements("idCategoriesProductes");
            $table->string("nom");
            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('categoria_productes');
    }
};
