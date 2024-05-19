<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    protected $fillable = ["idWishlist","nom"];
    public function up(): void
    {
        Schema::disableForeignKeyConstraints();
        Schema::create('wishlists', function (Blueprint $table) {
            $table->bigIncrements("idWishlist");
            $table->string("nom",40);
            $table->foreignId('idPropietari')->constrained('usuaris')->references('idUsuari');
            $table->foreignId('updated_by')->default(1)->constrained('usuaris')->references('idUsuari');
            $table->foreignId('created_by')->default(1)->constrained('usuaris')->references('idUsuari');
            $table->timestamps();
        });
        Schema::enableForeignKeyConstraints();
    }


    public function down(): void
    {
        Schema::dropIfExists('wishlists');
    }
};
