<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Linies extends Model
{
    use HasFactory;
    protected $table = "linies";
    protected $primaryKey = "idLinia";
    protected $fillable = ["idLinia","quantitat","preuUnitari","total"];
}
