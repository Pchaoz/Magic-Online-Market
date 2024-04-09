<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class TipusCartes extends Model
{
    use HasFactory;
    protected $table = "tipusCartes";
    protected $primaryKey = "idTipusCarta";
    protected $fillable = ["idTipusCarta","nom"];

}
