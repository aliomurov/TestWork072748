<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use Illuminate\Support\Facades\Auth;

class PagesController extends Controller
{
    public function index()
    {
        if(Auth::user()->role === 1){
            return response()->json([], 200);
        }
        else{
            return response()->json([], 401);
        }
    }
}
