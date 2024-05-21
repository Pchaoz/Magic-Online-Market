<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    protected $fillable = ["idWishlistArticle"];
    public function up(): void
    {
        Schema::create('whishlist_producte', function (Blueprint $table) {
            $table->bigIncrements("idWishlistProducte");
            $table->foreignId("idProducte")->constrained('productes')->references('idProducte');
            $table->foreignId("idWishlist")->constrained('wishlists')->references('idWishlist');
            $table->foreignId('updated_by')->default(1)->constrained('usuaris')->references('idUsuari');
            $table->foreignId('created_by')->default(1)->constrained('usuaris')->references('idUsuari');
            $table->timestamps();
        });
    }

    public function down(): void
    {
        Schema::dropIfExists('wishlist_article');
    }
};
