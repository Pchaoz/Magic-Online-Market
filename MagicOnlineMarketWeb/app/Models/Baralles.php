<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Baralles extends Model
{
    use HasFactory;
    protected $table = "baralles";
    protected $primaryKey = "idBaralla";
    protected $fillable = ["idBaralla","nom","isPublic"];
}
