<?php

/** @var \Laravel\Lumen\Routing\Router $router */

use App\Models\Item;

/*
|--------------------------------------------------------------------------
| Application Routes
|--------------------------------------------------------------------------
|
| Here is where you can register all of the routes for an application.
| It is a breeze. Simply tell Lumen the URIs it should respond to
| and give it the Closure to call when that URI is requested.
|
*/

$router->get('/', function () use ($router) {
    return $router->app->version();
});

$router->get('/info', function () use ($router) {
    return phpinfo();
});

$router->get('/items', function () {
    return Item::all();
});

$router->get('/items-test-add', function () {
    return Item::updateOrCreate(
        ['id' => null],
        ['name' => 'Item New 123'],
    );
});

$router->get('/items-test-upsert', function () {
    return Item::updateOrCreate(
        ['id' => 5],
        ['name' => 'Item New 5'],
    );
});


