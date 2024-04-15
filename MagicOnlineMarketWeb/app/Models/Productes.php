<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Productes extends Model
{
    use HasFactory;
    protected $table = "productes";
    protected $primaryKey = "idProducte";
    protected $fillable = ["idProducte","nom"];

    public function ofertes(){
        return $this->belongsToMany(User::class, 'ofertes', 'idProducte','idUsuari')->using(Ofertes::class)->withTimestamps();
    }

    public function categoriaProducte(){
        return $this->BelongsTo(CategoriaProductes::class, 'idCategoriesProductes', 'idCategoriesProductes');
    }

    public function expansioCarta(){
        return $this->BelongsTo(ExpansioCartes::class, 'idEexpansioCarta', 'idEexpansioCarta');
    }

}
