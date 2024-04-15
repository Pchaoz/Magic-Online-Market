<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class TipusCartesCartes extends Model
{
    use HasFactory;
    protected $table = "tipusCartesCartes";
    protected $primaryKey = "idTipusCartaCarta";
    protected $fillable = ["idTipusCartaCarta","idCarta","idTipusCarta"];
}
