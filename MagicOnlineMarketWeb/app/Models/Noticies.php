<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Noticies extends Model
{
    protected $table = "notices";
    protected $primaryKey = "idNoticia";
    protected $fillable = ["idNoticia"];
}
