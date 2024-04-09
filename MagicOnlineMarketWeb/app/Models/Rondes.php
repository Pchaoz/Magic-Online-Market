<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Rondes extends Model
{
    use HasFactory;
    protected $table = "rondes";
    protected $primaryKey = "idRonda";
    protected $fillable = ["idRonda","numeroRonda"];
}
