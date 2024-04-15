<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class ExpansioCartes extends Model
{
    use HasFactory;
    protected $table = "expansioCartes";
    protected $primaryKey = "idEexpansioCarta";
    protected $fillable = ["idEexpansioCarta","idCarta","idExpansio"];

    public function productes(){
        return $this->hasMany(Productes::class);
    }

    public function creador(){
        return $this->BelongsTo(User::class, 'idUser', 'updated_by');
    }

    public function actualizador(){
        return $this->BelongsTo(User::class, 'idUser', 'created_by');
    }
}
