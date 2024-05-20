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

    public function baralles()
    {
        return $this->hasMany(Baralles::class);
    }

    public function creartornejos()
    {
        return $this->hasMany(Tornejos::class);
    }

    public function direccions()
    {
        return $this->belongsToMany(Direccions::class, 'usuari_direccions', 'idUsuari','idDireccio')->using(UsuariDireccio::class)->withTimestamps();

    }

    public function comandesComprador()
    {
        return $this->hasMany(Comandes::class);
    }

    public function comandesVenedor()
    {
        return $this->hasMany(Comandes::class);
    }

    public function Articles(){
        return $this->belongsToMany(Productes::class, 'articles', 'idUsuari','idArticle')->using(Articles::class)->withTimestamps();
    }

    public function inscriure(){
        return $this->belongsToMany(Tornejos::class, 'participants', 'idUsuari','idTorneig')->using(Participacions::class)->withTimestamps();
    }

    //creador y actualizador de tablas
    public function creador(){
        return $this->BelongsTo(User::class, 'idUser', 'updated_by');
    }

    public function actualizador(){
        return $this->BelongsTo(User::class, 'idUser', 'created_by');
    }
    public function crearBarallaCarta()
    {
        return $this->hasMany(BarallaCartes::class);
    }

    public function actualitzarBarallaCarta()
    {
        return $this->hasMany(BarallaCartes::class);
    }

    public function crearBaralla()
    {
        return $this->hasMany(Baralles::class);
    }

    public function actualitzarBaralla()
    {
        return $this->hasMany(Baralles::class);
    }

    public function crearCarta()
    {
        return $this->hasMany(Carta::class);
    }

    public function actualitzarCarta()
    {
        return $this->hasMany(Carta::class);
    }

    public function crearCategoriaProducte()
    {
        return $this->hasMany(CategoriaProductes::class);
    }

    public function actualitzarCategoriaProducte()
    {
        return $this->hasMany(CategoriaProductes::class);
    }
    public function crearCiutat()
    {
        return $this->hasMany(Ciutats::class);
    }

    public function actualitzarCiutat()
    {
        return $this->hasMany(Ciutats::class);
    }

    public function crearComanada()
    {
        return $this->hasMany(Comandes::class);
    }

    public function actualitzarComanda()
    {
        return $this->hasMany(Comandes::class);
    }

    public function crearDireccio()
    {
        return $this->hasMany(Direccions::class);
    }

    public function actualitzarDireccio()
    {
        return $this->hasMany(Direccions::class);
    }

    public function crearEmparellament()
    {
        return $this->hasMany(Emparellaments::class);
    }

    public function actualitzarEmparellament()
    {
        return $this->hasMany(Emparellaments::class);
    }

    public function crearEnviament()
    {
        return $this->hasMany(Enviaments::class);
    }

    public function actualitzarEnviament()
    {
        return $this->hasMany(Enviaments::class);
    }

    public function crearExpansio()
    {
        return $this->hasMany(Expansions::class);
    }

    public function actualitzarExpansio()
    {
        return $this->hasMany(Expansions::class);
    }

    public function crearLinia()
    {
        return $this->hasMany(Linies::class);
    }

    public function actualitzarLinia()
    {
        return $this->hasMany(Linies::class);
    }

    public function crearNoticia()
    {
        return $this->hasMany(Noticies::class);
    }

    public function actualitzarNoticia()
    {
        return $this->hasMany(Noticies::class);
    }
    public function crearPais()
    {
        return $this->hasMany(Paisos::class);
    }

    public function actualitzarPais()
    {
        return $this->hasMany(Paisos::class);
    }

    public function crearParticipacio()
    {
        return $this->hasMany(Participacions::class);
    }

    public function actualitzarParticipacio()
    {
        return $this->hasMany(Participacions::class);
    }

    public function crearPremi()
    {
        return $this->hasMany(Premis::class);
    }

    public function actualitzarPremi()
    {
        return $this->hasMany(Premis::class);
    }

    public function crearProducte()
    {
        return $this->hasMany(Productes::class);
    }

    public function actualitzarProducte()
    {
        return $this->hasMany(Productes::class);
    }

    public function crearRonda()
    {
        return $this->hasMany(Rondes::class);
    }

    public function actualitzarRonda()
    {
        return $this->hasMany(Rondes::class);
    }

    public function crearTipusCarta()
    {
        return $this->hasMany(TipusCartes::class);
    }

    public function actualitzarTipusCarta()
    {
        return $this->hasMany(TipusCartes::class);
    }
    public function crearTipusCartaCarta()
    {
        return $this->hasMany(TipusCartesCartes::class);
    }

    public function actualitzarTipusCartaCarta()
    {
        return $this->hasMany(TipusCartesCartes::class);
    }
    public function crearTorneig()
    {
        return $this->hasMany(Tornejos::class);
    }

    public function actualitzarTorneig()
    {
        return $this->hasMany(Tornejos::class);
    }

    public function crearTipusTorneig()
    {
        return $this->hasMany(TipusTorneig::class);
    }

    public function actualitzarTipusTorneig()
    {
        return $this->hasMany(TipusTorneig::class);
    }

    public function crearTipusEnviament()
    {
        return $this->hasMany(Enviaments::class);
    }

    public function actualitzarTipusEnviament()
    {
        return $this->hasMany(Enviaments::class);
    }

    public function crearRol()
    {
        return $this->hasMany(Rols::class);
    }

    public function actualitzarRol()
    {
        return $this->hasMany(Rols::class);

    }

    public function crearArticle()
    {
        return $this->hasMany(Articles::class);
    }

    public function actualitzarArticle()
    {
        return $this->hasMany(Articles::class);
    }

    public function crearUsuariDireccio()
    {
        return $this->hasMany(UsuariDireccio::class);
    }

    public function actualitzarUsuariDireccio()
    {
        return $this->hasMany(UsuariDireccio::class);

    }

    public function crearUsuariResultat()
    {
        return $this->hasMany(Resultats::class);
    }

    public function actualitzarUsuariResultat()
    {
        return $this->hasMany(Resultats::class);

    }

    public function crearWhislist()
    {
        return $this->hasMany(Wishlist::class);
    }

    public function actualitzarWhislist()
    {
        return $this->hasMany(Wishlist::class);

    }

    public function crearWhislistArticles()
    {
        return $this->hasMany(WishlistProducte::class);
    }

    public function actualitzarWhislistArticles()
    {
        return $this->hasMany(WishlistProducte::class);

    }







}
