<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class TipusEnviaments extends Model
{
    use HasFactory;
    protected $table = "tipusEnviaments";
    protected $primaryKey = "idTipusEnviament";
    protected $fillable = ["idTipusEnviament","nom","preu"];
}
