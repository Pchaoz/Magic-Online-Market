<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Resultats extends Model
{
    use HasFactory;
    protected $table = "resultats";
    protected $primaryKey = "idResultat";
    protected $fillable = ["idResultat","resultatJugadorA","ResultatJugadorB"];

    public function empparellament(){
        return $this->hasMany(Emparellaments::class);
    }

    public function creador(){
        return $this->BelongsTo(User::class, 'idUser', 'updated_by');
    }

    public function actualizador(){
        return $this->BelongsTo(User::class, 'idUser', 'created_by');
    }}
