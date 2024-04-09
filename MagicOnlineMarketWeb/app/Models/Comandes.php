<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Comandes extends Model
{
    use HasFactory;
    protected $table = "comandes";
    protected $primaryKey = "idComanda";
    protected $fillable = ["idComanda","preu","isEnviament"];
}
