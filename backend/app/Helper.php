<?php

namespace App;

use Firebase\JWT\JWT;
use Illuminate\Http\Request;
use JsonMapper;

class Helper
{
    public static $allowedPaths = [
        'api/v1/login'
    ];

    public static function isAdmin(Request $request): bool
    {
        $payload = JWT::decode(
            $request->header('authorization',),
            env('JWT_SECRET'),
            ['HS256']
        );

        return property_exists($payload, 'admin') && $payload->admin;
    }

    public static function decodeJwt(string $jwt): object
    {
        return JWT::decode(
            $jwt,
            env('JWT_SECRET'),
            ['HS256']
        );
    }


    public static function hasToken(Request $request): array | null
    {
        if ($request->header('authorization')) {
            return JWT::decode(
                $request->header('authorization'),
                env('JWT_SECRET'),
                ['HS256']
            );
        } else {
            return null;
        }
    }

    public static function pathPassThrough(string $path): bool
    {
        return (current(array_filter(Helper::$allowedPaths, function ($p) use ($path) {
            return $path == $p;
        }))) ? true : false;
    }

    public static function parseBody(Request $request, $class): object
    {
        return Helper::getJsonMapper()->map(json_decode($request->getContent()), $class);
    }
 
    public static function parseBodyArray(Request $request, $class): object
    {
        return Helper::getJsonMapper()->mapArray(json_decode($request->getContent()), $class);
    }


    public static function getJsonMapper(): JsonMapper
    {
        $jm = new JsonMapper;
        $jm->bStrictNullTypes = false;

        return $jm;
    }
}
