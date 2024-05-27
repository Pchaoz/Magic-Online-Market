<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Premis extends Model
{
    use HasFactory;
    protected $table = "premis";
    protected $primaryKey = "idPremi";
    protected $fillable = ["idPremi","posicio","idProducte","idTornig","quantitat"];

    public function creador(){
        return $this->BelongsTo(User::class, 'idUser', 'updated_by');
    }

    public function actualizador(){
        return $this->BelongsTo(User::class, 'idUser', 'created_by');
    }
}
