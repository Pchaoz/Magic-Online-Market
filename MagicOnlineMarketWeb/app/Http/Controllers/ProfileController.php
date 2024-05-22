<?php

namespace App\Http\Controllers;

use Illuminate\Contracts\Auth\MustVerifyEmail;
use Illuminate\Http\RedirectResponse;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Redirect;
use Inertia\Inertia;
use Inertia\Response;

class ProfileController extends Controller
{

    public function edit(Request $request)
    {
        $usuaris= DB::table('usuaris')
            ->select('usuaris.nick AS nick')
            ->where('usuaris.idUsuari','<>',Auth::id())
            ->get();
        return Inertia::render('Profile/Edit', [
            'mustVerifyEmail' => $request->user() instanceof MustVerifyEmail,
            'status' => session('status'),
            'nicks'=>$usuaris,
        ]);
    }


    public function profileUpdate(Request $request)
    {
        $user = $request->user();
        $user->nick = $request->nick;
        $user->name = $request->name;
        $user->cognom = $request->cognom;
        $user->save();
    }

    public function destroy(Request $request): RedirectResponse
    {
        $request->validate([
            'password' => ['required', 'current_password'],
        ]);

        $user = $request->user();

        Auth::logout();

        $user->delete();

        $request->session()->invalidate();
        $request->session()->regenerateToken();

        return Redirect::to('/');
    }
}
