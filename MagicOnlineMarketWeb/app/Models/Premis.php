<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Premis extends Model
{
    use HasFactory;
    protected $table = "premis";
    protected $primaryKey = "idPremi";
    protected $fillable = ["idPremi","posicio","idProducte","idTornig"];
}
