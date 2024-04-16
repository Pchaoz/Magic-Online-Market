<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    protected $fillable = ["idRol","nom"];


    public function up(): void
    {
        Schema::disableForeignKeyConstraints();
        Schema::create('rols', function (Blueprint $table) {
            $table->bigIncrements("idRol");
            $table->string("nom");
            $table->foreignId('updated_by')->default(1)->constrained('usuaris')->references('idUsuari');
            $table->foreignId('created_by')->default(1)->constrained('usuaris')->references('idUsuari');
            $table->timestamps();
        });
        Schema::enableForeignKeyConstraints();


    }


    public function down(): void
    {
        Schema::dropIfExists('rols');
    }
};
