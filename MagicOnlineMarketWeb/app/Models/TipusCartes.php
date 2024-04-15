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


    public function tipuscartes(){
        return $this->belongsToMany(Cartes::class, 'cartes','idTipusCarta','idCarta')->using(TipusCartesCartes::class)->withTimestamps();
    }

    public function creador(){
        return $this->BelongsTo(User::class, 'idUser', 'updated_by');
    }

    public function actualizador(){
        return $this->BelongsTo(User::class, 'idUser', 'created_by');
    }


}
