<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Cartes extends Model
{
    use HasFactory;
    protected $table = "cartes";
    protected $primaryKey = "idCarta";
    protected $fillable = ["idCarta","nom","descripcio","imatge","raresa"];

    public function producte(){
        return $this->hasOne(Productes::class);
    }

    public function tipuscartes(){
        return $this->belongsToMany(TipusCartes::class, 'tipusCartes', 'idCarta','idTipusCarta')->using(TipusCartesCartes::class)->withTimestamps();
    }

    public function barallescartes(){
        return $this->belongsToMany(Baralles::class, 'baralla_cartes', 'idCarta','idbaralla')->using(BarallaCartes::class)->withTimestamps();
    }


    public function creador(){
        return $this->BelongsTo(User::class, 'idUser', 'updated_by');
    }

    public function actualizador(){
        return $this->BelongsTo(User::class, 'idUser', 'created_by');
    }
}
