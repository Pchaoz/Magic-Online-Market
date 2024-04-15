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


    public function isncrits(){
        return $this->belongsToMany(User::class, 'participants', 'idUsuari','idTorneig')->using(Participants::class)->withTimestamps();
    }


    public function tipus(){
        return $this->BelongsTo(TipusTorneig::class, 'idTipusTorneig', 'idTipusTorneig');
    }

    public function rondes(){
        return $this->hasMany(Rondes::class);
    }

    public function premis(){
        return $this->belongsToMany(Productes::class, 'premis', 'idPremi','idProducte')->using(Premis::class)->withTimestamps();
    }

    public function creador(){
        return $this->BelongsTo(User::class, 'idUser', 'updated_by');
    }

    public function actualizador(){
        return $this->BelongsTo(User::class, 'idUser', 'created_by');
    }
}
