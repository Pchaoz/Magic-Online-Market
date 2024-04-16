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
            $table->string("títol",100);
            $table->string("contingut");
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
