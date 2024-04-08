<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Rols extends Model
{
    protected $table = "rols";
    protected $primaryKey = "idRol";
    protected $fillable = ["idRol","nom"];

}
