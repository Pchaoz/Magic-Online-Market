<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class TipusEnviaments extends Model
{
    use HasFactory;
    protected $table = "tipus_enviaments";
    protected $primaryKey = "idTipusEnviament";
    protected $fillable = ["idTipusEnviament","nom","preu"];


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
