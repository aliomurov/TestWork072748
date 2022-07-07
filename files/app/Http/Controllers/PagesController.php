<?php

namespace App\Http\Controllers;

use App\Order;
use App\Product;
use App\Category;
use App\User;
use App\Wish;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Str;

class PagesController extends Controller
{
    public function index(Request $request)
    {
        $per_page = $request->per_page ? $request->per_page: 9;
        $categories = Category::latest()->get();
        $products = Product::orderBy('id', 'asc')->paginate($per_page);
        return response()->json(['categories' => $categories, 'products' => $products], 200);
    }

    public function category($id)
    {
        $categories = Category::latest()->get();
        $category = Category::with('product')->find($id);
        return response()->json(['category' => $category, 'categories' => $categories], 200);
    }
    
    public function catalog()
    {
        $categories = Category::latest()->get();
        return response()->json(['categories' => $categories], 200);
    }

    public function login(Request $request)
    {
        $credentials = $request->only('email', 'password');
        if(Auth::attempt($credentials)){
            $token = Str::random(80);
            Auth::user()->api_token = $token;
            Auth::user()->save();
            $client = Auth::user()->role != 1;
            return response()->json(['token'=>$token, 'client' => $client], 200);
        }
        return response()->json(['status'=>'Логин или пароль неверный'], 403);
    }

    public function company(Request $request)
    {
        if (User::where('email', '=', $request->email)->exists())
        {
            return response()->json(['status'=>'Такой email уже существует'], 403);
        }

        $company = User::create([
            'name' => $request->name,
            'email' => $request->email,
            'name_company' => $request->name_company,
            'address_company' => $request->address_company,
            'phone_company' => $request->phone_company,
            'type_company' => $request->type_company,
            'teams_company' => $request->teams_company,
            'city_company' => $request->city_company,
            'role' => 0,
            'password' => bcrypt($request->password),
        ]);

        $token = Str::random(80);
        $company->api_token = $token;
        $company->save();

        return response()->json(['company' => $company, 'token' => $token], 200);
    }

    public function profile()
    {
        if(Auth::check())
        {
            $user = auth()->user();
            return response()->json(['user' => $user], 200);
        }
    }

    public function profileOrder($id)
    {
        if(Auth::check()){
            $user = User::find($id);
            $orders = Order::where('user_id', '=', $user->id)->with('products')->latest()->get();
            return response()->json(['user' => $user, 'orders' => $orders], 200);
        }
    }

    public function profileUpdate(Request $request, $id)
    {
        if(Auth::check())
        {
            $user = User::find($id);
            $user->name = $request->name;
            $user->email = $request->email;
            $user->name_company = $request->name_company;
            $user->address_company = $request->address_company;
            $user->phone_company = $request->phone_company;
            $user->type_company = $request->type_company;
            $user->teams_company = $request->teams_company;
            $user->city_company = $request->city_company;
            $user->role = 0;
            if ($request->password)
            {
                $user->password = bcrypt($request->password);
            }
            $user->save();
            return response()->json(['user' => $user], 200);
        }
    }

    public function verify(Request $request)
    {
        return $request->user()->only('name', 'email');
    }
}
