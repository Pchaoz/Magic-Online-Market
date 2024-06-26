<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Comandes extends Model
{
    use HasFactory;
    protected $table = "comandes";
    protected $primaryKey = "idComanda";
    protected $fillable = ["idComanda","preuTotal","comisio","isEnviament","EstatComanda"];

    public function enviament(){
        return $this->hasOne(Enviaments::class);
    }

    public function comprador(){
        return $this->BelongsTo(User::class, 'idUsuari', 'idComprador');
    }

    public function venedor(){
        return $this->BelongsTo(User::class, 'idUsuari', 'idVenedor');
    }

    public function lines(){
        return $this->hasMany(Linies::class)->cascadeDelete();
    }

    public function creador(){
        return $this->BelongsTo(User::class, 'idUser', 'updated_by');
    }

    public function actualizador(){
        return $this->BelongsTo(User::class, 'idUser', 'created_by');
    }
}
