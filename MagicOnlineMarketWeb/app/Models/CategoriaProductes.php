<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class CategoriaProductes extends Model
{
    use HasFactory;
    protected $table = "categoriaProductes";
    protected $primaryKey = "idCategoriaProductes";
    protected $fillable = ["idCategoriaProductes","nom"];


    public function productes()
    {
        return $this->hasMany(Productes::class);
    }
}
