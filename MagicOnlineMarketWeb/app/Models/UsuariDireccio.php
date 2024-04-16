<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class UsuariDireccio extends Model
{
    use HasFactory;
    protected $table = "usuari_direccions";
    protected $primaryKey = "idUsuariDireccio";
    protected $fillable = ["idUsuariDireccio","idUsuari","idDireccio"];

    public function creador(){
        return $this->BelongsTo(User::class, 'idUser', 'updated_by');
    }

    public function actualizador(){
        return $this->BelongsTo(User::class, 'idUser', 'created_by');
    }
}
