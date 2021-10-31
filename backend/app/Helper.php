<?php

namespace App;

use Firebase\JWT\JWT;
use Illuminate\Http\Request;

class Helper
{
    public static function isAdmin(Request $request): bool
    {
        $payload = JWT::decode(
            $request->header('authorization',),
            env('JWT_SECRET'),
            ['HS256']
        );
        
        return property_exists($payload, 'admin') && $payload->admin;
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
}
