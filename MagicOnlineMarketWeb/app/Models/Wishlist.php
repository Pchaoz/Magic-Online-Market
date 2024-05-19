<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Wishlist extends Model
{
    use HasFactory;
    protected $table = "wishlists";
    protected $primaryKey = "idWishlist";
    protected $fillable = ["idWishlist","nom"];


    public function wishlistarticle(){
        return $this->belongsToMany(Cartes::class, 'wishlist_articles', 'idWishlist','idArticles')->using(WishlistArticle::class)->withTimestamps();
    }

    public function propietariWishlist(){
        return $this->BelongsTo(User::class, 'idUsuari', 'idPropietari');
    }

    public function articles(){
        return $this->hasMany(Articles::class);
    }

    public function creador(){
        return $this->BelongsTo(User::class, 'idUser', 'updated_by');
    }

    public function actualizador(){
        return $this->BelongsTo(User::class, 'idUser', 'created_by');
    }
}
