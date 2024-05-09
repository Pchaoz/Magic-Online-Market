<?php

use App\Http\Controllers\AuthController;
use App\Http\Controllers\ProfileController;
use Illuminate\Foundation\Application;
use Illuminate\Support\Facades\Route;
use Inertia\Inertia;

Route::get('/', function () {
    return Inertia::render('Welcome', [
        'canLogin' => Route::has('login'),
        'canRegister' => Route::has('register'),
        'laravelVersion' => Application::VERSION,
        'phpVersion' => PHP_VERSION,
    ]);
});

Route::get('/dashboard', function () {
    return Inertia::render('Dashboard');
})->middleware(['auth', 'verified'])->name('dashboard');

Route::middleware('auth')->group(function () {
    Route::get('/profile', [ProfileController::class, 'edit'])->name('profile.edit');
    Route::patch('/profile', [ProfileController::class, 'update'])->name('profile.update');
    Route::delete('/profile', [ProfileController::class, 'destroy'])->name('profile.destroy');
});

//funcions per usuaris/es
Route::get('/getAllUsers', [\App\Http\Controllers\UserController::class,'getAllUser'])->name('getAllUser');
require __DIR__.'/auth.php';
Route::get('/getAllUsersForm', [\App\Http\Controllers\UserController::class,'getUsersForm'])->name('getUsersForm');
require __DIR__.'/auth.php';
Route::delete('/deleteUser', [\App\Http\Controllers\UserController::class,'deleteUser'])->name('deleteUser');
Route::post('/editarUsuari', [\App\Http\Controllers\UserController::class,'editarUsuari'])->name('editarUsuari');
//-----------------------------------API----------------------------------------//
Route::get('/api/getUser', [\App\Http\Controllers\UserController::class,'APIgetUser'])->name('APIgetUser');



//funciones controller cartas
Route::get('/getAllCartes', [\App\Http\Controllers\CartesController::class,'ListCartes'])->name('getAllCartes');
Route::get('/getAllCartesByRaresa/{raresa}', [\App\Http\Controllers\CartesController::class,'getAllCartesByRaresa'])->name('getAllCartesByRaresa');
Route::get('/formulariCrearCartes',function (){
    return Inertia::render('formulariCreacioCartes');
})->name('formulariCartes');
Route::post('/crearCarta',[\App\Http\Controllers\CartesController::class, 'addCarta'])->name('addCarta');
Route::get('/formulariEditarCarta', [\App\Http\Controllers\CartesController::class,'FormEditCarta'])->name('FormEditCarta');
Route::post('/editarCarta',[\App\Http\Controllers\CartesController::class, 'editarCarta'])->name('editarCarta');
Route::get('/alterDescripcioCarta/{id}/{descripcio}', [\App\Http\Controllers\CartesController::class,'alterDescripcioCarta'])->name('alterDescripcioCarta');
Route::delete('/deleteCarta', [\App\Http\Controllers\CartesController::class,'deleteCarta'])->name('deleteCarta');
//-----------------------------------API----------------------------------------//
Route::get('/api/getAllCartes', [\App\Http\Controllers\CartesController::class,'APIListCartes'])->name('APIgetAllCartes');


//funcions controller rols
Route::get('/getAllRols', [\App\Http\Controllers\RolsController::class,'ListRols'])->name('ListRols');
Route::get('/getRol/{id}', [\App\Http\Controllers\RolsController::class,'getRol'])->name('getRol');
Route::post('/crearRol',[\App\Http\Controllers\RolsController::class, 'addRol'])->name('addRol');
Route::get('/modificarNomRol/{id}/{nom}',[\App\Http\Controllers\RolsController::class, 'modRol'])->name('modRol');
Route::post('/editarRol',[\App\Http\Controllers\RolsController::class,'editarRol'])->name('editarRol');
Route::delete('/eliminarRol',[\App\Http\Controllers\RolsController::class, 'eliminarRol'])->name('eliminarRol');


//-----------------------------------API----------------------------------------//
Route::get('/api/getAllRols', [\App\Http\Controllers\RolsController::class,'APIListRols'])->name('APIListRols');


//funcions controller productes
Route::get('/getAllProductes', [\App\Http\Controllers\ProductesController::class,'ListProductes'])->name('ListProductes');
Route::get('/getProducte/{id}', [\App\Http\Controllers\ProductesController::class,'getProducte'])->name('getProducte');
Route::get('/crearProducte/{nom}/{descripcio}/{idcategoria}',[\App\Http\Controllers\ProductesController::class, 'addProducte'])->name('addProducte');
Route::get('/modificarDescripcioProducte/{id}/{nom}',[\App\Http\Controllers\ProductesController::class, 'modProducte'])->name('modProducte');
Route::get('/eliminarProducte',[\App\Http\Controllers\ProductesController::class, 'eliminarProducte'])->name('eliminarProducte');
Route::get('/formModificarProducte',[\App\Http\Controllers\ProductesController::class, 'formModificarProducte'])->name('formModificarProducte');
Route::post('/modificarProducte',[\App\Http\Controllers\ProductesController::class, 'modificarProducte'])->name('modificarProducte');
Route::get('/formCrearProducte',[\App\Http\Controllers\ProductesController::class, 'formCrearProducte'])->name('formCrearProducte');
Route::post('/crearProducte',[\App\Http\Controllers\ProductesController::class, 'crearProducte'])->name('crearProducte');

//-----------------------------------API----------------------------------------//
Route::get('/api/getAllProductes', [\App\Http\Controllers\ProductesController::class,'APIListProductes'])->name('APIListProductes');
Route::get('/api/getLastProductes', [\App\Http\Controllers\ProductesController::class,'APILastProductes'])->name('APILastProductes');


//funcions controller Categoria Productes

//-----------------------------------API----------------------------------------//
Route::get('/api/getAllCategoriaProductes', [\App\Http\Controllers\CategoriaProducteController::class,'APICategoriaProductes'])->name('APICategoriaProductes');

//funcions controller Articles
Route::get('/crearArticle',[\App\Http\Controllers\ArticleController::class, 'crearArticle'])->name('crearArticle');
Route::get('/getAllArticles', [\App\Http\Controllers\ArticleController::class,'ListArticles'])->name('ListArticles');
Route::get('/veureOfertes/{id}',[\App\Http\Controllers\ArticleController::class, 'mostrarOfertesArticle'])->name('mostrarOfertesArticle');
Route::get('/modificarArticle',[\App\Http\Controllers\ArticleController::class, 'modificarArticle'])->name('modificarArticle');
Route::get('/eliminarArticle',[\App\Http\Controllers\ArticleController::class, 'eliminarArticle'])->name('eliminarArticle');

//-----------------------------------API----------------------------------------//
Route::get('/api/ofertes/{id}',[\App\Http\Controllers\ArticleController::class, 'APIgetArticleById'])->name('APIgetArticleById');

//funcions controller Noticies
Route::get('/llistaNoticies',[\App\Http\Controllers\NoticiesController::class, 'listNoticies'])->name('listNoticies');
Route::get('/eliminarNoticia/',[\App\Http\Controllers\NoticiesController::class, 'deleteNoticia'])->name('deleteNoticia');
Route::get('/formCrearNoticia',function (){
    return Inertia::render('formulariCreacioNoticia');
})->name('formCrearNoticia');
Route::post('/crearNoticia',[\App\Http\Controllers\NoticiesController::class, 'addNoticia'])->name('addNoticia');
Route::get('/veureNoticia/{id}',[\App\Http\Controllers\NoticiesController::class, 'seeNoticia'])->name('seeNoticia');
Route::get('/formModNoticia',[\App\Http\Controllers\NoticiesController::class, 'formModNoticia'])->name('formModNoticia');
Route::post('/modNoticia',[\App\Http\Controllers\NoticiesController::class, 'modNoticia'])->name('modNoticia');

//-----------------------------------API----------------------------------------//
Route::get('/api/noticies/{id}',[\App\Http\Controllers\NoticiesController::class, 'getNoticiaByIdAPI'])->name('getNoticiaByIdAPI');
Route::get('/api/noticies/',[\App\Http\Controllers\NoticiesController::class, 'getNoticiesAPI'])->name('getNoticiesAPI');
Route::get('/api/lastNoticies/',[\App\Http\Controllers\NoticiesController::class, 'getLastNews'])->name('getLastNews');

//funcions controller Comandes
Route::get('/listComandes',[\App\Http\Controllers\ComandesController::class, 'listComandes'])->name('listComandes');
Route::post('/crearComanda',[\App\Http\Controllers\ComandesController::class, 'addComanda'])->name('addComanda');
Route::delete('/eliminarComanda',[\App\Http\Controllers\ComandesController::class, 'eliminarComanda'])->name('eliminarComanda');


//funcions controller Linies
Route::get('/veureLinies/{id}',[\App\Http\Controllers\LiniesController::class, 'veureLiniesComanda'])->name('veureLiniesComanda');
Route::delete('/eliminarLinia',[\App\Http\Controllers\LiniesController::class, 'eliminarLinia'])->name('eliminarLinia');


//----------------------------------- API USER ----------------------------------------//
Route::post('/api/login', [AuthController::class, 'login']);
Route::post('/api/register', [AuthController::class, 'register']);
Route::post('/api/logout', [AuthController::class, 'logout']);
Route::post('/api/update', [AuthController::class, 'update']);


