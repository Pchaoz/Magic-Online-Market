<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class CategoriaProductes extends Model
{
    use HasFactory;
    protected $table = "categoriesProductes";
    protected $primaryKey = "idCategoriesProductes";
    protected $fillable = ["idCategoriesProductes","nom"];
}
