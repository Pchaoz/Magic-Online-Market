<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    protected $fillable = ["idBaralla","nom","isPublic"];

    public function up(): void
    {
        Schema::disableForeignKeyConstraints();
        Schema::create('baralles', function (Blueprint $table) {
            $table->bigIncrements("idBaralla");
            $table->string("nom",40);
            $table->boolean("isPublic")->default(false);
            $table->foreignId('idCreador')->constrained('usuaris')->references('idUsuari');
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
        Schema::dropIfExists('baralles');
    }
};
