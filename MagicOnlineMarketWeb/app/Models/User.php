<?php

namespace App\Models;

// use Illuminate\Contracts\Auth\MustVerifyEmail;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Foundation\Auth\User as Authenticatable;
use Illuminate\Notifications\Notifiable;

class User extends Authenticatable
{
    use HasFactory, Notifiable;

    protected $table = "usuaris";
    protected $primaryKey = "idUsuari";
    protected $fillable = [
        'idUsuari',
        'nick',
        'name',
        'cognom',
        'email',
        'password',
        'mitjanaVenedor',
        'numeroVendes',
        'saldo'

    ];

    /**
     * The attributes that should be hidden for serialization.
     *
     * @var array<int, string>
     */
    protected $hidden = [
        'password',
        'remember_token',
    ];

    /**
     * Get the attributes that should be cast.
     *
     * @return array<string, string>
     */
    protected function casts(): array
    {
        return [
            'email_verified_at' => 'datetime',
            'password' => 'hashed',
        ];
    }

    public function rols(){
        return $this->BelongsTo(Rols::class, 'idRol', 'idRol');
    }

    public function noticies()
    {
        return $this->hasMany(Noticies::class);
    }

    public function direccions()
    {
        return $this->hasMany(Direccions::class);
    }

    public function comandas()
    {
        return $this->hasMany(Comandes::class);
    }

    public function Ofertes(){
        return $this->belongsToMany(Productes::class, 'ofertes', 'idUsuari','idProducte')->using(Ofertes::class)->withTimestamps();
    }


}
