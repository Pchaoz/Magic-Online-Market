<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Linies extends Model
{
    use HasFactory;
    protected $table = "linies";
    protected $primaryKey = "idLinia";
    protected $fillable = ["idLinia","quantitat","total"];

    public function comanda(){
        return $this->BelongsTo(Comandes::class, 'idComanda', 'idComanda');
    }
    public function oferta(){
        return $this->BelongsTo(Articles::class, 'idOferta', 'idOferta');
    }

    public function creador(){
        return $this->BelongsTo(User::class, 'idUser', 'updated_by');
    }

    public function actualizador(){
        return $this->BelongsTo(User::class, 'idUser', 'created_by');
    }
}
