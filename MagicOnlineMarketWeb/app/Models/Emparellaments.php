<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Emparellaments extends Model
{
    use HasFactory;
    protected $table = "emparellaments";
    protected $primaryKey = "idEmparellament";
    protected $fillable = ["idEmparellament","resultat","numRonda","ronda"];

    public function torneig(){
        return $this->BelongsTo(Tornejos::class, 'idTorneig', 'idTorneig');
    }


    public function participantA(){
        return $this->BelongsTo(Participacions::class, 'idParticipant', 'idParticipantA');
    }

    public function participantB(){
        return $this->BelongsTo(Participacions::class, 'idParticipant', 'idParticipantB');
    }

    public function creador(){
        return $this->BelongsTo(User::class, 'idUser', 'updated_by');
    }

    public function actualizador(){
        return $this->BelongsTo(User::class, 'idUser', 'created_by');
    }
}
