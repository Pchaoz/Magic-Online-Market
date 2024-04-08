<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class ExpansioCartes extends Model
{
    use HasFactory;
    protected $table = "expansioCartes";
    protected $primaryKey = "idEexpansioCartes";
    protected $fillable = ["idEexpansioCartes"];
}
