<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Direccions extends Model
{
    use HasFactory;
    protected $table = "direccions";
    protected $primaryKey = "idDireccio";
    protected $fillable = ["idDireccio","direccio","codiPostal"];

    public function ciutat(){
        return $this->BelongsTo(Ciutats::class, 'idCiutat', 'idCiutat');
    }

    public function propietari(){
        return $this->BelongsTo(User::class, 'idUsuari', 'idUsuari');
    }

    public function enviaments(){
        return $this->hasMany(Enviaments::class);
    }

    public function creador(){
        return $this->BelongsTo(User::class, 'idUser', 'updated_by');
    }

    public function actualizador(){
        return $this->BelongsTo(User::class, 'idUser', 'created_by');
    }
}
