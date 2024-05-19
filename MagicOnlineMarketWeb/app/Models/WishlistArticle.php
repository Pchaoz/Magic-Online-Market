<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class WishlistArticle extends Model
{
    use HasFactory;
    protected $table = "whishlist_article";
    protected $primaryKey = "idWishlistArticle";
    protected $fillable = ["idWishlistArticle","idWishlist","idArticle"];

    public function creador(){
        return $this->BelongsTo(User::class, 'idUser', 'updated_by');
    }

    public function actualizador(){
        return $this->BelongsTo(User::class, 'idUser', 'created_by');
    }
}
