<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class WishlistProducte extends Model
{
    use HasFactory;
    protected $table = "whishlist_producte";
    protected $primaryKey = "idWishlistProducte";
    protected $fillable = ["idWishlistProducte","idWishlist","idArticle"];

    public function creador(){
        return $this->BelongsTo(User::class, 'idUser', 'updated_by');
    }

    public function actualizador(){
        return $this->BelongsTo(User::class, 'idUser', 'created_by');
    }
}
