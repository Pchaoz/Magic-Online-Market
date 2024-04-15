<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Expansions extends Model
{
    use HasFactory;
    protected $table = "expansions";
    protected $primaryKey = "idExpansio";
    protected $fillable = ["idExpansio","nom","dataSortida"];


    public function expansioncartes(){
        return $this->belongsToMany(Cartes::class, 'expansioCartes', 'idExpansio','idCarta')->using(ExpansioCartes::class)->withTimestamps();
    }

}
