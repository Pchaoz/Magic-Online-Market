<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Tornejos extends Model
{
    use HasFactory;
    protected $table = "tornejos";
    protected $primaryKey = "idTorneig";
    protected $fillable = ["idTorneig","numparticipants","minParticipants","maxParticipants","numeroRondes","horaInici"];

    public function organitzador(){
        return $this->BelongsTo(User::class, 'idUsuari', 'idOrganitzador');
    }
}
