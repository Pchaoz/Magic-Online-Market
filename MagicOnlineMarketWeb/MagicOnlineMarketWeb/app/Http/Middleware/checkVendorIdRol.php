<?php

namespace App\Http\Middleware;

use Closure;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Symfony\Component\HttpFoundation\Response;

class checkVendorIdRol
{
    /**
     * Handle an incoming request.
     *
     * @param  \Closure(\Illuminate\Http\Request): (\Symfony\Component\HttpFoundation\Response)  $next
     */
    public function handle(Request $request, Closure $next): Response
    {
        $idRolUser=Auth::user()->idRol;

        if($idRolUser=='1'||$idRolUser=='5'||$idRolUser=='4'){
            return $next($request);

        }else{
            return redirect()->route('dashboard');
        }
    }
}
