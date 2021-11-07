<?php

namespace App\Http\Middleware;

use App\Helper;
use Closure;
use Firebase\JWT\JWT;

class FilterMiddleware
{
    /**
     * Handle an incoming request.
     *
     * @param  \Illuminate\Http\Request  $request
     * @param  \Closure  $next
     * @return mixed
     */
    public function handle($request, Closure $next)
    {
        // dd($request->path());

        if (Helper::pathPassThrough($request->path())) {
            return $next($request);
        }

        // Check token
        // dd(env('JWT_SECRET'));
        if (!Helper::decodeJwt($request->header('authorization'))) {
            return response('Unauthorized access. No token', 403);
        }

        return $next($request);
    }
}
