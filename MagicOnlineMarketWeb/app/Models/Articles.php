<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Articles extends Model
{
    use HasFactory;
    protected $table = "articles";
    protected $primaryKey = "idArticle";
    protected $fillable = ["idArticle","quantitatDisponible","preuUnitari","idProducte","idVenedor"];

    public function lines(){
        return $this->hasMany(Linies::class);
    }

    public function creador(){
        return $this->BelongsTo(User::class, 'idUser', 'updated_by');
    }

    public function actualizador(){
        return $this->BelongsTo(User::class, 'idUser', 'created_by');
    }

}
