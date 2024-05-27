<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{

    public function up(): void
    {
        Schema::create('noticies', function (Blueprint $table) {
            $table->bigIncrements("idNoticia");
            $table->string("titol",100);
            $table->string("subtitol",150)->nullable();
            $table->string("imatge")->nullable();
            $table->string("contingut",2500)->nullable();
            $table->timestamp("dataHoraPublicacio")->default(now());
            $table->foreignId('idCreador')->nullable()->constrained('usuaris')->references('idUsuari');
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
        Schema::dropIfExists('noticies');
    }
};
