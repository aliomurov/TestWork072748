<?php

namespace App\Http\Controllers\Api;

use Illuminate\Http\Request;
use App\Http\Controllers\Controller;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Str;

class LoginController extends Controller
{
    public function login(Request $request)
    {
        $credentials = $request->only('email', 'password');
        if(Auth::attempt($credentials)){
            $token = Str::random(80);
            Auth::user()->api_token = $token;
            Auth::user()->save();
            $admin = Auth::user()->role === 2 || Auth::user()->role === 1;
            $adminName = Auth::user()->name;
            return response()->json(['token'=>$token, 'isAdmin' => $admin, 'adminName' => $adminName], 200);
        }
        return response()->json(['status'=>'Логин или пароль неверный'], 403);
    }

    public function verify(Request $request)
    {
        return $request->user()->only('name', 'email');
    }
}
