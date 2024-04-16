<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Cartes extends Model
{
    use HasFactory;
    protected $table = "cartes";
    protected $primaryKey = "idCarta";
    protected $fillable = ["idCarta","nom","descripcio","imatge"];

    public function expansioncartes(){
        return $this->belongsToMany(ExpansioCartes::class, 'expansioCartes', 'idCarta','idExpansio')->using(ExpansioCartes::class)->withTimestamps();
    }

    public function tipuscartes(){
        return $this->belongsToMany(TipusCartes::class, 'tipusCartes', 'idCarta','idTipusCarta')->using(TipusCartesCartes::class)->withTimestamps();
    }

    public function barallescartes(){
        return $this->belongsToMany(Baralles::class, 'baralla_cartes', 'idCarta','idbaralla')->using(BarallaCartes::class)->withTimestamps();
    }
    public function raresa(){
        return $this->BelongsTo(Raresa::class, 'idRaresa', 'idRaresa');
    }

    public function creador(){
        return $this->BelongsTo(User::class, 'idUser', 'updated_by');
    }

    public function actualizador(){
        return $this->BelongsTo(User::class, 'idUser', 'created_by');
    }
}
