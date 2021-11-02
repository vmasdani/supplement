<?php

/** @var \Laravel\Lumen\Routing\Router $router */

use App\Helper;
use App\Models\Customer;
use App\Models\Item;
use App\Models\Transaction;
use App\Models\TransactionItem;
use App\Models\Uom;
use App\Models\User;
use Firebase\JWT\JWT;
use Illuminate\Http\Request;
use PhpParser\JsonDecoder;

use function App\testFunction;

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

$router->get('/gen', function () use ($router) {
    $runeStr = 'abcdefghijklmopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';
    $rune = str_split($runeStr);

    $secret = '';

    for ($i = 0; $i < 32; $i++) {
        $ch = $rune[rand(0, strlen($runeStr) - 1)];
        $secret = "$secret$ch";
    }

    return $secret;
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


$router->group(['prefix' => 'api/v1',], function () use ($router) {
    $router->post('/login', function (Request $request) {
        $body = json_decode($request->getContent());

        // Check admin first
        if ($body?->username == env('ADMIN_USERNAME') && $body?->password == env('ADMIN_PASSWORD')) {
            return [
                'token' => JWT::encode(['admin' => true], env('JWT_SECRET'))
            ];
        }

        $foundUser = User::where('username', $body?->username)->first();

        if ($foundUser) {
            if (password_verify($body?->password, $foundUser->password)) {
                return [
                    'token' => JWT::encode(['id' => $foundUser->id], env('JWT_SECRET'))
                ];
            } else {
                return response('Password incorrect', 403);
            }
        } else {
            return response('User not found', 404);
        }
    });
    // Populator
    $router->get('/init', function () use ($router) {
        foreach (['kg', 'm', 'unit', 'gr'] as $uomStr) {
            $foundUom = Uom::where('name', '=', $uomStr)->first();

            if ($foundUom) {
                // return response()->json($foundUom->toArray());
            } else {
                // return response()->json(['not found ' . $uomStr], 200);
                Uom::updateOrCreate(['id' => null], ['name' => $uomStr]);
            }
        }
    });

    $router->group(['middleware' => 'filter'], function () use ($router) {


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

        // Transactions
        $router->get('/transactions', function () {
            return Transaction::all();
        });
        $router->get('/transactions/{id}', function ($id) {
            return Transaction::findOrFail($id);
        });
        $router->post('/transactions', function (Request $request) {
            $t = json_decode($request->getContent());
            return Transaction::updateOrCreate(['id' => $t?->id], (array) $t);
        });
        $router->delete('/transactions/{id}', function ($id) {
            Transaction::findOrFail($id)?->delete($id);
        });
        $router->post('/transactions-test-add', function () {
            // dd(strtotime((new DateTime('now'))->format('Y-m-d H:i:s')));
            // dd(((explode('T', (new DateTime('now'))->format(DateTime::ISO8601))[0]).'T00:00:00Z'));
            $savedTransaction = Transaction::updateOrCreate(['id' => 0], [
                'name' => 'Test transaction',
                'date' => ((explode('T', (new DateTime('now'))->format(DateTime::ISO8601))[0]) . 'T00:00:00Z'),
                'date_real' => ((explode('T', (new DateTime('now'))->format(DateTime::ISO8601))[0]) . 'T00:00:00Z'),
                'timestamp' => ((explode('T', (new DateTime('now'))->format(DateTime::ISO8601))[0]) . 'T00:00:00Z'),
                'date_non_tz' => ((explode('T', (new DateTime('now'))->format(DateTime::ISO8601))[0]) . 'T00:00:00Z'),
                'timestamp_non_tz' => ((explode('T', (new DateTime('now'))->format(DateTime::ISO8601))[0]) . 'T00:00:00Z'),

                // 'date' => (new DateTime('now'))->getTimestamp(),
                // 'date' => '2021- z10-30 00:00:00',
            ]);

            if ($savedTransaction) {
                TransactionItem::updateOrCreate(['id' => null], [
                    'transaction_id' => $savedTransaction->id,
                    'remark' => 'My remark'
                ]);
                TransactionItem::updateOrCreate(['id' => null], [
                    'transaction_id' => $savedTransaction->id,
                    'remark' => 'My remark 2'
                ]);
            }

            return $savedTransaction;
        });


        // Users
        $router->get('/users', function (Request $request) {
            return Helper::isAdmin($request)
                ? User::all()
                : response('Unauthorized', 401);
        });

        $router->get('/users-simple', function () {
            return User::all()->map(function ($u) {
                $u->password = null;
                return $u;
            });
        });

        $router->post('/users', function (Request $request) {
            /**
             * {
             *      "user": null,
             *      "changePassword": false,
             *      "newPassword": "",
             *      "customer": null
             * }
             */
            $body = json_decode($request->getContent());

            if ($body?->changePassword && $body?->user) {
                $body->user->password = password_hash($body->newPassword, PASSWORD_DEFAULT);
            }

            $savedUser = User::updateOrCreate(['id' => $body?->user?->id], (array) $body?->user);

            if ($body?->customer) {
                $body->customer->user_id = $savedUser?->id;
                Customer::updateOrCreate(['id' => $body?->customer?->id], (array) $body?->customer);
            }

            return $savedUser;
        });


        // Customers
        $router->get('/customers', function () {
            return Customer::all();
        });
        $router->post('/customers', function (Request $request) {
            $c = json_decode($request->getContent());
            return Customer::updateOrCreate(['id' => $c?->id], (array) $c);
        });
    });
});
