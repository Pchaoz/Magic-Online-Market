<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class ExpansioCartes extends Model
{
    use HasFactory;
    protected $table = "expansioCartes";
    protected $primaryKey = "idEexpansioCarta";
    protected $fillable = ["idEexpansioCarta","idCarta","idExpansio"];

    public function productes(){
        return $this->hasMany(Productes::class);
    }
}
