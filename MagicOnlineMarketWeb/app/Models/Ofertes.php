<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Ofertes extends Model
{
    use HasFactory;
    protected $table = "ofertes";
    protected $primaryKey = "idOferta";
    protected $fillable = ["idOferta","quantitat","preu","idProducte","idVenedor"];

    public function lines(){
        return $this->hasMany(Linies::class);
    }

}
