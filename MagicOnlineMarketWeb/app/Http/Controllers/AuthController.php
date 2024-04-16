<?php

namespace App\Http\Controllers;

use App\Models\User;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Validation\ValidationException;

class AuthController extends Controller
{
    public function login(Request $request) {

        $request->validate([
            'email' => 'required|email',
            'password' => 'required',
        ]);

        if (Auth::attempt($request->only('email', 'password'))) {
            return response()->json(['user' => Auth::user()]);
        }

        throw ValidationException::withMessages([
            'email' => ['The provided credentials are incorrect.'],
        ]);
    }
    public function register(Request $request)
    {

        $request->validate([
            'firstName' => 'required|string|max:255',
            'email' => 'required|string|email|max:255|unique:users',
            'password' => 'required|string|min:8|confirmed',
            'lastName' => 'required|string',
            'nickname' => 'required|string'

        ]);

        $user = User::create([
            'name' => $request->firstName,
            'email' => $request->email,
            'password' => bcrypt($request->password),
            'nick' => $request->nickname,
            'cognom' => $request->lastName,
        ]);

        Auth::login($user);

        return response()->json(['user' => $user]);
    }

    public function logout(Request $request)
    {
        Auth::logout();
        return response()->json(['message' => 'User logged out']);
    }

}
