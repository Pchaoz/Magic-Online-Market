<?php

namespace App\Http\Controllers;

use App\Models\User;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Hash;
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
            'nick' => $request->nickname,
            'email' => $request->email,
            'password' => bcrypt($request->password),
            'name' => $request->firstName,
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

    public function APIeditUser(Request $request) {
        $user = User::find($request->idUsuari);

        if (!$user) {
            return response()->json(['message' => 'Usuario no encontrado'], 404);
        }

        // Comprobar si la contraseña actual es la actual
        if (!Hash::check($request->_passwordActual, $user->password)) {
            return response()->json(['message' => 'La contraseña actual no es correcta'], 400);
        }

        // Comprobar si el nick ya existe
        $nickExists = User::where('nick', $request->nick)->where('idUsuari', '!=', $request->idUsuari)->exists();
        if ($nickExists) {
            return response()->json(['message' => 'El nick ya está en uso por otro usuario'], 400);
        }

        // Comprobar si el email ya existe
        $emailExists = User::where('email', $request->email)->where('idUsuari', '!=', $request->idUsuari)->exists();
        if ($emailExists) {
            return response()->json(['message' => 'El email ya está en uso por otro usuario'], 400);
        }

        $user->nick = $request->nick;
        $user->name = $request->name;
        $user->cognom = $request->cognom;
        $user->email = $request->email;
        $user->password = Hash::make($request->password);

        $user->save();

        return response()->json(['message' => 'Usuario actualizado con éxito'], 200);
    } 
}
