<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Cartes extends Model
{
    use HasFactory;
    protected $table = "cartes";
    protected $primaryKey = "idCarta";
    protected $fillable = ["idCarta","nom","costMana"];
}
