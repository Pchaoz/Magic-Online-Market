<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class BarallaCartes extends Model
{
    use HasFactory;
    protected $table = "baralla_cartes";
    protected $primaryKey = "idBarallaCarta";
    protected $fillable = ["idBarallaCarta","quantitat","idBaralla","idCarta"];

    public function creador(){
        return $this->BelongsTo(User::class, 'idUser', 'updated_by');
    }

    public function actualizador(){
        return $this->BelongsTo(User::class, 'idUser', 'created_by');
    }
}
