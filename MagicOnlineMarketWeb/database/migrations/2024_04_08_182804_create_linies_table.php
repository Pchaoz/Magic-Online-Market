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
            $table->foreignId("idComanda")->nullable()->constrained('comandes')->references('idComanda')->onDelete('cascade');;
            $table->foreignId("idArticle")->nullable()->constrained('articles')->references('idArticle');
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
        Schema::dropIfExists('linies');
    }
};
