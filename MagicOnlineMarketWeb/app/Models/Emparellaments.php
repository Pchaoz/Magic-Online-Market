<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Emparellaments extends Model
{
    use HasFactory;
    protected $table = "emparellaments";
    protected $primaryKey = "idEmparellament";
    protected $fillable = ["idEmparellament","resultat"];

    public function ronda(){
        return $this->BelongsTo(Rondes::class, 'idRonda', 'idRonda');
    }


    public function participanteA(){
        return $this->BelongsTo(Participants::class, 'idParticipant', 'idParticipantA');
    }

    public function participanteB(){
        return $this->BelongsTo(Participants::class, 'idParticipant', 'idParticipantB');
    }
}
