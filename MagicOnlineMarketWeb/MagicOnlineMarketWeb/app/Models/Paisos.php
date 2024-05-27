<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Paisos extends Model
{
    use HasFactory;
    protected $table = "paisos";
    protected $primaryKey = "idPais";
    protected $fillable = ["idPais","nom"];

    public function ciutats()
    {
        return $this->hasMany(Ciutats::class);
    }

    public function creador(){
        return $this->BelongsTo(User::class, 'idUser', 'updated_by');
    }

    public function actualizador(){
        return $this->BelongsTo(User::class, 'idUser', 'created_by');
    }

}
