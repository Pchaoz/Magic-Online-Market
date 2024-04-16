<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Participacions extends Model
{
    use HasFactory;
    protected $table = "participacions";
    protected $primaryKey = "idParticipacio";
    protected $fillable = ["idParticipacio","puntuacio","idUsuari","idTorneig"];


    public function emparellamentA(){
        return $this->hasMany(Emparellaments::class);
    }
    public function emparellamentB(){
        return $this->hasMany(Emparellaments::class);
    }
    public function creador(){
        return $this->BelongsTo(User::class, 'idUser', 'updated_by');
    }

    public function actualizador(){
        return $this->BelongsTo(User::class, 'idUser', 'created_by');
    }

}
