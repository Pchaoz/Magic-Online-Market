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
Route::get('/getAllUsers', [\App\Http\Controllers\userController::class,'getAllUser'])->name('getAllUser');
require __DIR__.'/auth.php';
Route::get('/getAllUsersForm', [\App\Http\Controllers\userController::class,'getUsersForm'])->name('getUsersForm');
require __DIR__.'/auth.php';
Route::delete('/deleteUser/{id}', [\App\Http\Controllers\userController::class,'deleteUser'])->name('deleteUser');



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
Route::delete('/deleteCarta/{id}', [\App\Http\Controllers\CartesController::class,'deleteCarta'])->name('deleteCarta');
//-----------------------------------API----------------------------------------//
Route::get('/api/getAllCartes', [\App\Http\Controllers\CartesController::class,'APIListCartes'])->name('APIgetAllCartes');



//funcions controller rols
Route::get('/getAllRols', [\App\Http\Controllers\RolsController::class,'ListRols'])->name('ListRols');
Route::get('/getRol/{id}', [\App\Http\Controllers\RolsController::class,'getRol'])->name('getRol');
Route::post('/crearRol',[\App\Http\Controllers\RolsController::class, 'addRol'])->name('addRol');
Route::get('/modificarNomRol/{id}/{nom}',[\App\Http\Controllers\RolsController::class, 'modRol'])->name('modRol');
Route::post('/editarRol',[\App\Http\Controllers\RolsController::class,'editarRol'])->name('editarRol');
Route::get('/eliminarRol/{id}/',[\App\Http\Controllers\RolsController::class, 'deleteRol'])->name('deleteRol');


//-----------------------------------API----------------------------------------//
Route::get('/api/getAllRols', [\App\Http\Controllers\RolsController::class,'APIListRols'])->name('APIListRols');


//funcions controller productes
Route::get('/getAllProductes', [\App\Http\Controllers\ProductesController::class,'ListProductes'])->name('ListProductes');
Route::get('/whereProductes/{idCategoriaProductes}', [\App\Http\Controllers\ProductesController::class,'whereProductes'])->name('whereProductes');
Route::get('/getProducte/{id}', [\App\Http\Controllers\ProductesController::class,'getProducte'])->name('getProducte');
Route::get('/crearProducte/{nom}/{descripcio}/{idcategoria}',[\App\Http\Controllers\ProductesController::class, 'addProducte'])->name('addProducte');
Route::get('/modificarDescripcioProducte/{id}/{nom}',[\App\Http\Controllers\ProductesController::class, 'modProducte'])->name('modProducte');
Route::delete('/eliminarProducte',[\App\Http\Controllers\ProductesController::class, 'eliminarProducte'])->name('eliminarProducte');
Route::post('/modificarProducte',[\App\Http\Controllers\ProductesController::class, 'modificarProducte'])->name('modificarProducte');
Route::post('/crearProducte',[\App\Http\Controllers\ProductesController::class, 'crearProducte'])->name('crearProducte');

//-----------------------------------API----------------------------------------//
Route::get('/api/getAllProductes', [\App\Http\Controllers\ProductesController::class,'APIListProductes'])->name('APIListProductes');
Route::get('/api/getLastProductes', [\App\Http\Controllers\ProductesController::class,'APILastProductes'])->name('APILastProductes');


//funcions controller Categoria Productes



//-----------------------------------API----------------------------------------//
Route::get('/api/getAllCategoriaProductes', [\App\Http\Controllers\CategoriaProducteController::class,'APICategoriaProductes'])->name('APICategoriaProductes');


//----------------------------------- API LOGIN ----------------------------------------//
Route::post('/api/login', [AuthController::class, 'login']);
Route::post('/api/register', [AuthController::class, 'register']);
Route::post('/api/logout', [AuthController::class, 'logout']);
