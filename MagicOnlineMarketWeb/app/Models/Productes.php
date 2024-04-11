<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Productes extends Model
{
    use HasFactory;
    protected $table = "productes";
    protected $primaryKey = "idProducte";
    protected $fillable = ["idProducte","nom"];

    public function Ofertes(){
        return $this->belongsToMany(User::class, 'ofertes', 'idProducte','idUsuari')->using(Ofertes::class)->withTimestamps();
    }

}
