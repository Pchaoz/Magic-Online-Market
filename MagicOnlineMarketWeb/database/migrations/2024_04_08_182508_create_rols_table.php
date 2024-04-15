<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    protected $fillable = ["idRol","nom"];


    public function up(): void
    {
        Schema::create('rols', function (Blueprint $table) {
            $table->bigIncrements("idRol");
            $table->string("nom");
            $table->timestamps();
        });
    }

   
    public function down(): void
    {
        Schema::dropIfExists('rols');
    }
};
