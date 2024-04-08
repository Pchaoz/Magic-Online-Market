<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Emparellaments extends Model
{
    use HasFactory;
    protected $table = "emparellaments";
    protected $primaryKey = "idEmparellament";
    protected $fillable = ["idEmparellament","resultado"];
}
