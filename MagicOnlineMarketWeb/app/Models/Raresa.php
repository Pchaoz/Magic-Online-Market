<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Raresa extends Model
{
    use HasFactory;
    protected $table = "rareses";
    protected $primaryKey = "idRaresa";
    protected $fillable = ["idRaresa","nom"];

    public function raresaCarta(){
        return $this->hasMany(Cartes::class);
    }

    public function creador(){
        return $this->BelongsTo(User::class, 'idUser', 'updated_by');
    }

    public function actualizador(){
        return $this->BelongsTo(User::class, 'idUser', 'created_by');
    }



}
