<?php

namespace App\Http\Controllers;

use App\Models\User;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Validator;
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

        $validator = Validator::make($request->all(), [
            'nickname'=>'required|string|max:20',
            'firstName' => 'required|string|max:255',
            'lastName' => 'string|max:30',
            'email' => 'required|string|max:255|unique:'.User::class,
            'password' => 'required',
        ]);

        if ($validator->fails()) {
            return response()->json($validator->errors(), 400);
        }

        $user = User::create([
            'firstName' => $request->firstName,
            'email' => $request->email,
            'password' => bcrypt($request->password),
            'nickname' => $request->nickname,
            'lastName' => $request->lastName,
        ]);
        //Auth::login($user);

        return response()->json(['user' => $user]);
    }

    public function logout(Request $request)
    {
        Auth::logout();
        return response()->json(['message' => 'User logged out']);
    }

}
