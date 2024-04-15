<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Baralles extends Model
{
    use HasFactory;
    protected $table = "baralles";
    protected $primaryKey = "idBaralla";
    protected $fillable = ["idBaralla","nom","isPublic"];


    public function barallescartes(){
        return $this->belongsToMany(Cartes::class, 'baralla_cartes', 'idbaralla','idCarta')->using(BarallaCartes::class)->withTimestamps();
    }

    public function creador(){
        return $this->BelongsTo(User::class, 'idUsuari', 'idCreador');
    }
}
