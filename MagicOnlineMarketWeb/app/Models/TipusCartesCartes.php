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

    public function creador(){
        return $this->BelongsTo(User::class, 'idUser', 'updated_by');
    }

    public function actualizador(){
        return $this->BelongsTo(User::class, 'idUser', 'created_by');
    }
}
