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

    public function premis(){
        return $this->belongsToMany(Tornejos::class, 'premis', 'idProducte','idPremi')->using(Premis::class)->withTimestamps();
    }

    public function categoriaProducte(){
        return $this->BelongsTo(CategoriaProductes::class, 'idCategoriesProductes', 'idCategoriesProductes');
    }

    public function expansioCarta(){
        return $this->BelongsTo(ExpansioCartes::class, 'idEexpansioCarta', 'idEexpansioCarta');
    }

    public function creador(){
        return $this->BelongsTo(User::class, 'idUser', 'updated_by');
    }

    public function actualizador(){
        return $this->BelongsTo(User::class, 'idUser', 'created_by');
    }

}
