<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Paisos extends Model
{
    use HasFactory;
    protected $table = "paisos";
    protected $primaryKey = "idPais";
    protected $fillable = ["idPais","nom"];

}
