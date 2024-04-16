<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Noticies extends Model
{
    protected $table = "notices";
    protected $primaryKey = "idNoticia";
    protected $fillable = ["idNoticia","titol","contingut","dataHoraPublicacio"];


    public function user(){
        return $this->BelongsTo(User::class, 'idUsuari', 'idUsuari');
    }

    public function creador(){
        return $this->BelongsTo(User::class, 'idUser', 'updated_by');
    }

    public function actualizador(){
        return $this->BelongsTo(User::class, 'idUser', 'created_by');
    }
}
