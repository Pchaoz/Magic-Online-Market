<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Productes extends Model
{
    use HasFactory;
    protected $table = "productes";
    protected $primaryKey = "idProducte";
    protected $fillable = ["idProducte","nom","descripcio","imatge"];

    public function ofertes(){
        return $this->belongsToMany(User::class, 'ofertes', 'idProducte','idUsuari')->using(Articles::class)->withTimestamps();
    }

    public function premis(){
        return $this->belongsToMany(Tornejos::class, 'premis', 'idProducte','idPremi')->using(Premis::class)->withTimestamps();
    }

    public function whishlistProducte(){
        return $this->belongsToMany(Baralles::class, 'whishlist_producte', 'idProducte','idWishlist')->using(WishlistProducte::class)->withTimestamps();
    }

    public function cartes(){
        return $this->hasOne(Cartes::class);
    }

    public function categoriaProducte(){
        return $this->belongsTo(CategoriaProductes::class, 'idCategoriaProducte', 'idCategoriaProductes');
    }
    public function expansioProducte(){
        return $this->BelongsTo(Expansions::class, 'idExpansio', 'idExpansio');
    }

    public function carta(){
        return $this->BelongsTo(Cartes::class, 'idCarta', 'idCarta');
    }

    public function creador(){
        return $this->BelongsTo(User::class, 'idUser', 'updated_by');
    }

    public function actualizador(){
        return $this->BelongsTo(User::class, 'idUser', 'created_by');
    }

}
