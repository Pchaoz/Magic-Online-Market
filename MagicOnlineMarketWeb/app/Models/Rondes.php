<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Rondes extends Model
{
    use HasFactory;
    protected $table = "rondes";
    protected $primaryKey = "idRonda";
    protected $fillable = ["idRonda","numeroRonda"];

    public function torneig(){
        return $this->BelongsTo(Tornejos::class, 'idTorneig', 'idTorneig');
    }

    public function emparellaments(){
        return $this->hasMany(Emparellaments::class);
    }

    public function creador(){
        return $this->BelongsTo(User::class, 'idUser', 'updated_by');
    }

    public function actualizador(){
        return $this->BelongsTo(User::class, 'idUser', 'created_by');
    }
}
