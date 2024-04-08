<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class BarallaCartes extends Model
{
    use HasFactory;
    protected $table = "barallaCartes";
    protected $primaryKey = "idBarallaCarta";
    protected $fillable = ["idBarallaCarta","quantitat"];
}
