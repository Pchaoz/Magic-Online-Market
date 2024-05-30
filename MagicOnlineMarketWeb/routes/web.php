<?php

use App\Http\Controllers\AuthController;
use App\Http\Controllers\ProfileController;
use Illuminate\Foundation\Application;
use Illuminate\Support\Facades\Route;
use App\Http\Controllers\PayPalController;
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

Route::get('/profile', [ProfileController::class, 'edit'])->name('profile.edit');
Route::post('/profile.update', [\App\Http\Controllers\ProfileController::class, 'profileUpdate'])->name('profile.update');
Route::delete('/profile', [ProfileController::class, 'destroy'])->name('profile.destroy');


//funcions per usuaris/es
Route::get('/getAllUsers', [\App\Http\Controllers\UserController::class,'getAllUser'])->name('getAllUser')->middleware(\App\Http\Middleware\checkSuperIdRol::class);
require __DIR__.'/auth.php';
Route::get('/getAllUsersForm', [\App\Http\Controllers\UserController::class,'getUsersForm'])->name('getUsersForm')->middleware(\App\Http\Middleware\checkSuperIdRol::class);
require __DIR__.'/auth.php';
Route::delete('/deleteUser', [\App\Http\Controllers\UserController::class,'deleteUser'])->name('deleteUser')->middleware(\App\Http\Middleware\checkSuperIdRol::class);
Route::post('/editarUsuari', [\App\Http\Controllers\UserController::class,'editarUsuari'])->name('editarUsuari')->middleware(\App\Http\Middleware\checkSuperIdRol::class);
//-----------------------------------API----------------------------------------//
Route::get('/api/getUser/{id}', [\App\Http\Controllers\UserController::class,'APIgetUser'])->name('APIgetUser');
Route::get('/api/getSalary/{id}', [\App\Http\Controllers\UserController::class,'getSaldoAPI'])->name('getSaldoAPI');

//funciones controller cartas
Route::get('/getAllCartes', [\App\Http\Controllers\CartesController::class,'ListCartes'])->name('getAllCartes');
Route::get('/getAllCartesByRaresa/{raresa}', [\App\Http\Controllers\CartesController::class,'getAllCartesByRaresa'])->name('getAllCartesByRaresa');
Route::get('/formulariCrearCartes',function (){
    return Inertia::render('formulariCreacioCartes');
})->name('formulariCartes')->middleware(\App\Http\Middleware\checkUserIdRol::class);
Route::post('/crearCarta',[\App\Http\Controllers\CartesController::class, 'addCarta'])->name('addCarta')->middleware(\App\Http\Middleware\checkUserIdRol::class);
Route::get('/formulariEditarCarta', [\App\Http\Controllers\CartesController::class,'FormEditCarta'])->name('FormEditCarta')->middleware(\App\Http\Middleware\checkUserIdRol::class);
Route::post('/editarCarta',[\App\Http\Controllers\CartesController::class, 'editarCarta'])->name('editarCarta')->middleware(\App\Http\Middleware\checkUserIdRol::class);
Route::get('/alterDescripcioCarta/{id}/{descripcio}', [\App\Http\Controllers\CartesController::class,'alterDescripcioCarta'])->name('alterDescripcioCarta')->middleware(\App\Http\Middleware\checkUserIdRol::class);
Route::delete('/deleteCarta', [\App\Http\Controllers\CartesController::class,'deleteCarta'])->name('deleteCarta')->middleware(\App\Http\Middleware\checkUserIdRol::class);
//-----------------------------------API----------------------------------------//
Route::get('/api/getAllCartes', [\App\Http\Controllers\CartesController::class,'APIListCartes'])->name('APIgetAllCartes');


//funcions controller rols
Route::get('/getAllRols', [\App\Http\Controllers\RolsController::class,'ListRols'])->name('ListRols')->middleware(\App\Http\Middleware\checkSuperIdRol::class);
Route::get('/getRol/{id}', [\App\Http\Controllers\RolsController::class,'getRol'])->name('getRol')->middleware(\App\Http\Middleware\checkSuperIdRol::class);
Route::post('/crearRol',[\App\Http\Controllers\RolsController::class, 'addRol'])->name('addRol')->middleware(\App\Http\Middleware\checkSuperIdRol::class);
Route::get('/modificarNomRol/{id}/{nom}',[\App\Http\Controllers\RolsController::class, 'modRol'])->name('modRol')->middleware(\App\Http\Middleware\checkSuperIdRol::class);
Route::post('/editarRol',[\App\Http\Controllers\RolsController::class,'editarRol'])->name('editarRol')->middleware(\App\Http\Middleware\checkSuperIdRol::class);
Route::delete('/eliminarRol',[\App\Http\Controllers\RolsController::class, 'eliminarRol'])->name('eliminarRol')->middleware(\App\Http\Middleware\checkSuperIdRol::class);

//-----------------------------------API----------------------------------------//
Route::get('/api/getAllRols', [\App\Http\Controllers\RolsController::class,'APIListRols'])->name('APIListRols');

//funcions controller productes
Route::get('/getAllProductes', [\App\Http\Controllers\ProductesController::class,'ListProductes'])->name('ListProductes');
Route::get('/getProducte/{id}', [\App\Http\Controllers\ProductesController::class,'getProducte'])->name('getProducte');
Route::get('/crearProducte/{nom}/{descripcio}/{idcategoria}',[\App\Http\Controllers\ProductesController::class, 'addProducte'])->name('addProducte')->middleware(\App\Http\Middleware\checkUserIdRol::class);
Route::get('/modificarDescripcioProducte/{id}/{nom}',[\App\Http\Controllers\ProductesController::class, 'modProducte'])->name('modProducte')->middleware(\App\Http\Middleware\checkUserIdRol::class);
Route::get('/eliminarProducte',[\App\Http\Controllers\ProductesController::class, 'eliminarProducte'])->name('eliminarProducte')->middleware(\App\Http\Middleware\checkUserIdRol::class);
Route::get('/formModificarProducte',[\App\Http\Controllers\ProductesController::class, 'formModificarProducte'])->name('formModificarProducte')->middleware(\App\Http\Middleware\checkUserIdRol::class);
Route::post('/modificarProducte',[\App\Http\Controllers\ProductesController::class, 'modificarProducte'])->name('modificarProducte')->middleware(\App\Http\Middleware\checkUserIdRol::class);
Route::get('/formCrearProducte',[\App\Http\Controllers\ProductesController::class, 'formCrearProducte'])->name('formCrearProducte')->middleware(\App\Http\Middleware\checkUserIdRol::class);
Route::post('/crearProducte',[\App\Http\Controllers\ProductesController::class, 'crearProducte'])->name('crearProducte')->middleware(\App\Http\Middleware\checkUserIdRol::class);

//-----------------------------------API----------------------------------------//
Route::get('/api/getAllProductes', [\App\Http\Controllers\ProductesController::class,'APIListProductes'])->name('APIListProductes');
Route::get('/api/getLastProductes', [\App\Http\Controllers\ProductesController::class,'APILastProductes'])->name('APILastProductes');

//funcions controller Articles
Route::get('/crearArticle',[\App\Http\Controllers\ArticleController::class, 'crearArticle'])->name('crearArticle')->middleware(\App\Http\Middleware\checkVendorIdRol::class);
Route::get('/getAllArticles', [\App\Http\Controllers\ArticleController::class,'ListArticles'])->name('ListArticles');
Route::get('/veureArticlesProducte/{id}',[\App\Http\Controllers\ArticleController::class, 'veureArticlesProducte'])->name('veureArticlesProducte');
Route::get('/modificarArticle',[\App\Http\Controllers\ArticleController::class, 'modificarArticle'])->name('modificarArticle')->middleware(\App\Http\Middleware\checkVendorIdRol::class);
Route::get('/eliminarArticle',[\App\Http\Controllers\ArticleController::class, 'eliminarArticle'])->name('eliminarArticle')->middleware(\App\Http\Middleware\checkVendorIdRol::class);

//-----------------------------------API----------------------------------------//
Route::get('/api/ofertes/{id}',[\App\Http\Controllers\ArticleController::class, 'APIgetArticleById'])->name('APIgetArticleById');
Route::post('/api/uploadArticle', [\App\Http\Controllers\ArticleController::class,'APIuploadArticle']);
Route::put('/api/updateArticle', [\App\Http\Controllers\ArticleController::class,'updateArticleAPI']);
Route::get('/api/recentOfertes',[\App\Http\Controllers\ArticleController::class, 'APIgetLastOfertes'])->name('APIgetLastOfertes');
Route::get('/api/ofertesUsuari/{id}', [\App\Http\Controllers\ArticleController::class, 'APIGetUserArticlesByID'])->name('APIGetUserArticlesByID');
Route::delete('/api/deleteArticle/', [\App\Http\Controllers\ArticleController::class,'deleteArticleAPI'])->name('deleteArticleAPI');;

//funcions controller Noticies
Route::get('/llistaNoticies',[\App\Http\Controllers\NoticiesController::class, 'listNoticies'])->name('listNoticies');
Route::get('/eliminarNoticia/',[\App\Http\Controllers\NoticiesController::class, 'deleteNoticia'])->name('deleteNoticia')->middleware(\App\Http\Middleware\checkUserIdRol::class);
Route::get('/formCrearNoticia',function (){
    return Inertia::render('formulariCreacioNoticia');
})->name('formCrearNoticia')->middleware(\App\Http\Middleware\checkUserIdRol::class);
Route::post('/crearNoticia',[\App\Http\Controllers\NoticiesController::class, 'addNoticia'])->name('addNoticia')->middleware(\App\Http\Middleware\checkUserIdRol::class);
Route::get('/veureNoticia/{id}',[\App\Http\Controllers\NoticiesController::class, 'seeNoticia'])->name('seeNoticia');
Route::get('/formModNoticia',[\App\Http\Controllers\NoticiesController::class, 'formModNoticia'])->name('formModNoticia')->middleware(\App\Http\Middleware\checkUserIdRol::class);
Route::post('/modNoticia',[\App\Http\Controllers\NoticiesController::class, 'modNoticia'])->name('modNoticia')->middleware(\App\Http\Middleware\checkUserIdRol::class);

//-----------------------------------API----------------------------------------//
Route::get('/api/noticies/{id}',[\App\Http\Controllers\NoticiesController::class, 'getNoticiaByIdAPI'])->name('getNoticiaByIdAPI');
Route::get('/api/noticies/',[\App\Http\Controllers\NoticiesController::class, 'getNoticiesAPI'])->name('getNoticiesAPI');
Route::get('/api/lastNoticies/',[\App\Http\Controllers\NoticiesController::class, 'getLastNews'])->name('getLastNews');

//funcions controller Comandes
Route::get('/listComandes',[\App\Http\Controllers\ComandesController::class, 'listComandes'])->name('listComandes')->middleware(\App\Http\Middleware\checkUserIdRol::class);
Route::get('/listComandesCompres',[\App\Http\Controllers\ComandesController::class, 'listComandesCompres'])->name('listComandesCompres');
Route::get('/listComandesVendes',[\App\Http\Controllers\ComandesController::class, 'listComandesVendes'])->name('listComandesVendes')->middleware(\App\Http\Middleware\checkVendorIdRol::class);
Route::get('/listComandesCompraUser',[\App\Http\Controllers\ComandesController::class, 'listComandesCompraUser'])->name('listComandesCompraUser');
Route::post('/crearComanda',[\App\Http\Controllers\ComandesController::class, 'addComanda'])->name('addComanda');
Route::post('/agregarArticleComanda',[\App\Http\Controllers\ComandesController::class, 'agregarArticleComanda'])->name('agregarArticleComanda');
Route::delete('/buidarCompra',[\App\Http\Controllers\ComandesController::class, 'buidarCompra'])->name('buidarCompra');
Route::delete('/eliminarComanda',[\App\Http\Controllers\ComandesController::class, 'eliminarComanda'])->name('eliminarComanda');
Route::post('/confirmarCompra',[\App\Http\Controllers\ComandesController::class, 'confirmarCompra'])->name('confirmarCompra');
Route::post('/confirmarPagament',[\App\Http\Controllers\ComandesController::class, 'confirmarPagament'])->name('confirmarPagament');
Route::post('/confirmarNouEstat',[\App\Http\Controllers\ComandesController::class, 'confirmarNouEstat'])->name('confirmarNouEstat');
Route::post('/anularComanda',[\App\Http\Controllers\ComandesController::class, 'anularComanda'])->name('anularComanda')->middleware(\App\Http\Middleware\checkUserIdRol::class);

//funcions controller Linies
Route::get('/veureLinies/{id}',[\App\Http\Controllers\LiniesController::class, 'veureLiniesComanda'])->name('veureLiniesComanda');
Route::delete('/eliminarLinia',[\App\Http\Controllers\LiniesController::class, 'eliminarLinia'])->name('eliminarLinia');
Route::delete('/eliminarLiniaCarret',[\App\Http\Controllers\LiniesController::class, 'eliminarLiniaCarret'])->name('eliminarLiniaCarret');

//----------------------------------- API USER ----------------------------------------//
//funcions controller Expansions
Route::get('/getAllExpansions', [\App\Http\Controllers\ExpansionsController::class,'ListExpansions'])->name('ListExpansions')->middleware(\App\Http\Middleware\checkUserIdRol::class);
Route::post('/crearExpansio',[\App\Http\Controllers\ExpansionsController::class, 'crearExpansio'])->name('crearExpansio')->middleware(\App\Http\Middleware\checkUserIdRol::class);
Route::post('/editarExpansio',[\App\Http\Controllers\ExpansionsController::class,'editarExpansio'])->name('editarExpansio')->middleware(\App\Http\Middleware\checkUserIdRol::class);
Route::delete('/eliminarExpansio',[\App\Http\Controllers\ExpansionsController::class, 'eliminarExpansio'])->name('eliminarExpansio')->middleware(\App\Http\Middleware\checkUserIdRol::class);

//funcions controller Categoria Productes
Route::get('/getAllCategProductes', [\App\Http\Controllers\CategoriaProducteController::class,'ListCategProductes'])->name('ListCategProductes')->middleware(\App\Http\Middleware\checkUserIdRol::class);
Route::post('/crearCategProductes',[\App\Http\Controllers\CategoriaProducteController::class, 'crearCategProductes'])->name('crearCategProductes')->middleware(\App\Http\Middleware\checkUserIdRol::class);
Route::post('/editarCategProductes',[\App\Http\Controllers\CategoriaProducteController::class,'editarCategProductes'])->name('editarCategProductes')->middleware(\App\Http\Middleware\checkUserIdRol::class);
Route::delete('/eliminarCategProductes',[\App\Http\Controllers\CategoriaProducteController::class, 'eliminarCategProductes'])->name('eliminarCategProductes')->middleware(\App\Http\Middleware\checkUserIdRol::class);

//-----------------------------------API----------------------------------------//
Route::get('/api/getAllCategoriaProductes', [\App\Http\Controllers\CategoriaProducteController::class,'APICategoriaProductes'])->name('APICategoriaProductes');

//funcions controller Baralles
Route::get('/getAllBaralles', [\App\Http\Controllers\BarallesController::class,'ListBaralles'])->name('ListBaralles');
Route::get('/ListBarallesMeves', [\App\Http\Controllers\BarallesController::class,'ListBarallesMeves'])->name('ListBarallesMeves');
Route::get('/veureBaralla/{id}', [\App\Http\Controllers\BarallesController::class,'seeBaralla'])->name('seeBaralla');
Route::post('/agregarCartaBaralla', [\App\Http\Controllers\BarallesController::class,'agregarCartaBaralla'])->name('agregarCartaBaralla');
Route::delete('/deleteCartaBaralla', [\App\Http\Controllers\BarallesController::class,'deleteCartaBaralla'])->name('deleteCartaBaralla');
Route::post('/modCartaBaralla', [\App\Http\Controllers\BarallesController::class,'modCartaBaralla'])->name('modCartaBaralla');
Route::delete('/deleteBaralla', [\App\Http\Controllers\BarallesController::class,'deleteBaralla'])->name('deleteBaralla');
Route::post('/crearBaralla', [\App\Http\Controllers\BarallesController::class,'crearBaralla'])->name('crearBaralla');
Route::post('/editarBaralla', [\App\Http\Controllers\BarallesController::class,'editarBaralla'])->name('editarBaralla');
//-----------------------------------API----------------------------------------//
Route::get('/api/getAllBaralles', [\App\Http\Controllers\BarallesController::class,'getAllBaralles'])->name('getAllBaralles');
Route::get('/api/getBarallaByUser/{id}', [\App\Http\Controllers\BarallesController::class,'getBarallesByUserID'])->name('getBarallesByUserID');
Route::get('/api/getBarallaByID/{id}', [\App\Http\Controllers\BarallesController::class,'seeBarallaByID'])->name('seeBarallaByID');
Route::post('/api/createBaralla', [\App\Http\Controllers\BarallesController::class,'createBatallaAPI'])->name('createBatallaAPI');
Route::put('/api/addCartaBaralla', [\App\Http\Controllers\BarallesController::class,'addCardAPI'])->name('addCardAPI');
Route::put('/api/updateCartaBaralla', [\App\Http\Controllers\BarallesController::class,'updateCartaBarallaAPI'])->name('updateCartaBarallaAPI');
Route::delete('/api/deleteCartaBatalla', [\App\Http\Controllers\BarallesController::class,'deleteCartaBarallaAPI'])->name('deleteCartaBarallaAPI');
Route::put('/api/updateBaralla', [\App\Http\Controllers\BarallesController::class,'editarBarallaAPI'])->name('editarBarallaAPI');
Route::delete('/api/deleteBaralla', [\App\Http\Controllers\BarallesController::class,'deleteBarallaAPI'])->name('deleteBarallaAPI');

//funcions controller Wishlist
Route::get('/ListWhishlistsMeves', [\App\Http\Controllers\WishlistControler::class,'ListWhishlistsMeves'])->name('ListWhishlistsMeves');
Route::get('/ListWhishlists', [\App\Http\Controllers\WishlistControler::class,'ListWhishlists'])->name('ListWhishlists')->middleware(\App\Http\Middleware\checkUserIdRol::class);
Route::post('/crearWishlist', [\App\Http\Controllers\WishlistControler::class,'crearWishlist'])->name('crearWishlist');
Route::delete('/eliminarWishlist', [\App\Http\Controllers\WishlistControler::class,'eliminarWishlist'])->name('eliminarWishlist');
Route::post('/modWishlist', [\App\Http\Controllers\WishlistControler::class,'modWishlist'])->name('modWishlist');
Route::get('/veureWishlist/{id}', [\App\Http\Controllers\WishlistControler::class,'veureWishlist'])->name('veureWishlist');
Route::delete('/eliminarProducteWishlist', [\App\Http\Controllers\WishlistControler::class,'eliminarProducteWishlist'])->name('eliminarProducteWishlist');
Route::post('/afegirProducteWishlist', [\App\Http\Controllers\WishlistControler::class,'afegirProducteWishlist'])->name('afegirProducteWishlist');

//-----------------------------------API----------------------------------------//
Route::get('/api/getWishlistUser/{id}', [\App\Http\Controllers\WishlistControler::class,'getWishlistsByUserID'])->name('getWishlistsByUserID');
Route::post('/api/createNewWishList', [\App\Http\Controllers\WishlistControler::class,'createNewWishList'])->name('createNewWishList');
Route::get('/api/getWishListByWishListID/{id}', [\App\Http\Controllers\WishlistControler::class,'getWishListByWishListID'])->name('getWishListByWishListID');
Route::post('/api/addProductToWishlist', [\App\Http\Controllers\WishlistControler::class,'addProductToWishlistAPI'])->name('addProductToWishlistAPI');
Route::delete('/api/removeFromWishlist', [\App\Http\Controllers\WishlistControler::class,'removeFromWishlist'])->name('removeFromWishlist');
Route::delete('/api/removeWishList', [\App\Http\Controllers\WishlistControler::class,'deleteWishlist'])->name('deleteWishlist');

//funcions controller Tornejos
Route::get('/getAllTornejos', [\App\Http\Controllers\TornejosController::class,'ListTornejos'])->name('ListTornejos');

//PAYPAL
Route::post('/api/paypal/order', [PayPalController::class, 'createOrder']);
Route::post('/api/paypal/capture', [PayPalController::class, 'captureOrder']);
Route::get('/api/paypal/success', [PayPalController::class, 'success']);
Route::get('/api/paypal/cancel', [PayPalController::class, 'cancel']);
//-----------------------------------API----------------------------------------//
//funcions tipus enviaments
Route::get('/ListTipusEnviaments', [\App\Http\Controllers\TipusEnviamentsController::class,'ListTipusEnviaments'])->name('ListTipusEnviaments')->middleware(\App\Http\Middleware\checkUserIdRol::class);
Route::post('/crearTipusEnviament', [\App\Http\Controllers\TipusEnviamentsController::class,'crearTipusEnviament'])->name('crearTipusEnviament')->middleware(\App\Http\Middleware\checkUserIdRol::class);
Route::delete('/eliminarTipusEnviament', [\App\Http\Controllers\TipusEnviamentsController::class,'eliminarTipusEnviament'])->name('eliminarTipusEnviament')->middleware(\App\Http\Middleware\checkUserIdRol::class);
Route::post('/modTipusEnviament', [\App\Http\Controllers\TipusEnviamentsController::class,'modTipusEnviament'])->name('modTipusEnviament')->middleware(\App\Http\Middleware\checkUserIdRol::class);

//funcions direccions
Route::get('/ListUserdirections', [\App\Http\Controllers\DireccionsController::class,'ListUserdirections'])->name('ListUserdirections');
Route::post('/crearDireccio', [\App\Http\Controllers\DireccionsController::class,'crearDireccio'])->name('crearDireccio');
Route::delete('/eliminarDireccio', [\App\Http\Controllers\DireccionsController::class,'eliminarDireccio'])->name('eliminarDireccio');
Route::post('/modDireccio', [\App\Http\Controllers\DireccionsController::class,'modDireccio'])->name('modDireccio');

//----------------------------------- API LOGIN ----------------------------------------//
Route::post('/api/login', [AuthController::class, 'login']);
Route::post('/api/register', [AuthController::class, 'register']);
Route::post('/api/logout', [AuthController::class, 'logout']);
Route::put('/api/updateUser',[AuthController::class, 'APIeditUser'])->name('APIeditUser');
