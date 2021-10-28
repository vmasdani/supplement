<?php

/** @var \Laravel\Lumen\Routing\Router $router */

use App\Models\Item;
use App\Models\Uom;
use Laravel\Lumen\Http\Request;

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
        [
            'name' => 'Item New 123',
            'description' => 'item description right here.',
            'price' => 300000.21,
            'uom_id' => (function () {
                return Uom::where('name', 'kg')?->first()?->id ?? null;
            })()
        ],
    );
});

$router->get('/items-test-upsert', function () {
    return Item::updateOrCreate(
        ['id' => 5],
        ['name' => 'Item New 5'],
    );
});


$router->group(['prefix' => 'api/v1', 'middleware' => 'filter'], function () use ($router) {
    // Populator
    $router->get('/populate', function () use ($router) {
        foreach (['kg', 'm', 'unit'] as $uomStr) {
            $foundUom = Uom::where('name', '=', $uomStr)->first();

            if ($foundUom) {
                // return response()->json($foundUom->toArray());
            } else {
                // return response()->json(['not found ' . $uomStr], 200);
                Uom::updateOrCreate(['id' => null], ['name' => $uomStr]);
            }
        }
    });
    // UoM
    $router->get('/uoms', function () {
        return Uom::all();
    });
    $router->delete('/uoms/{id}', function ($id) {
        Uom::findOrFail($id)?->delete($id);
    });
    // Items
    $router->get('/items', function () {
        return Item::all()->map(function ($i) {
            $i?->uom;
            return $i;
        });
    });
    $router->get('/items/{id}', function ($id) {
        $item = Item::findOrFail($id);
        $item?->uom;

        return $item;
    });
    $router->post('/items', function (Request $request) {
        $i = json_decode($request->getContent());
        return Item::updateOrCreate(['id' => $i?->id], (array) $i);
    });
    $router->delete('/items/{id}', function ($id) {
        Item::findOrFail($id)?->delete($id);
    });
    // Users
    
});
