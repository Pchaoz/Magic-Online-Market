<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Ciutats extends Model
{
    use HasFactory;
    protected $table = "ciutats";
    protected $primaryKey = "idCiutat";
    protected $fillable = ["idCiutat","nom"];

    public function pais(){
        return $this->BelongsTo(Paisos::class, 'idPais', 'idPais');
    }

    public function direccions()
    {
        return $this->hasMany(Direccions::class);
    }

    public function creador(){
        return $this->BelongsTo(User::class, 'idUser', 'updated_by');
    }

    public function actualizador(){
        return $this->BelongsTo(User::class, 'idUser', 'created_by');
    }

}
