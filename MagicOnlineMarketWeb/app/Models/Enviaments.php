<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Enviaments extends Model
{
    use HasFactory;
    protected $table = "enviaments";
    protected $primaryKey = "idEnviament";
    protected $fillable = ["idEnviament"];

    public function direccio(){
        return $this->BelongsTo(Direccions::class, 'idDireccio', 'idDesti');
    }
    public function tipusneviament(){
        return $this->BelongsTo(TipusEnviaments::class, 'idTipusEnviament', 'idTipusEnviament');
    }

    public function comanda(){
        return $this->hasOne(Comandes::class);
    }
}
