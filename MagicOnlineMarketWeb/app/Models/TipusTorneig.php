<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class TipusTorneig extends Model
{
    use HasFactory;
    protected $table = "tipusTornejos";
    protected $primaryKey = "idTipusTorneig";
    protected $fillable = ["idTipusTorneig","descripcio"];

    public function lines(){
        return $this->hasMany(Tornejos::class);
    }
}
