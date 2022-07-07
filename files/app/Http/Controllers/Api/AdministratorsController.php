<?php

namespace App\Http\Controllers\Api;

use App\User;
use Illuminate\Http\Request;
use App\Http\Controllers\Controller;
use Illuminate\Support\Facades\Auth;

class AdministratorsController extends Controller
{
    public function index(Request $request)
    {
        if(Auth::user()->role === 1){
            $per_page = $request->per_page ? $request->per_page: 5;
            return response()->json(['administrators' => User::where('role', '!=', 0)->paginate($per_page)], 200);
        }
        else{
            return response()->json([], 401);
        }
    }

    public function show($id)
    {
        $administrators = User::where('name', 'LIKE', "%$id%")->paginate();
        return response()->json(['administrators' => $administrators], 200);
    }

    public function store(Request $request)
    {
        if(Auth::user()->role === 1)
        {
            if (User::where('email', '=', $request->email)->exists())
            {
                return response()->json(['status'=>'Такой email уже существует'], 403);
            }

            $administrator = User::create([
                'name' => $request->name,
                'email' => $request->email,
                'role' => $request->role,
                'password' => bcrypt($request->password),
            ]);
            return response()->json(['administrator' => $administrator], 200);
        }
        else{
            return response()->json(['status'=>'У вас нет права изменять добавлять удалять администраторов'], 403);
        }
    }

    public function edit($id)
    {
        $administrator = User::find($id);
        return response()->json(['administrator' => $administrator], 200);
    }

    public function update(Request $request, $id)
    {
        if(Auth::user()->role == 1)
        {
            $administrator = User::find($id);
            $administrator->name = $request->name;
            $administrator->email = $request->email;
            $administrator->role = $request->role;
            if ($request->password)
            {
                $administrator->password = bcrypt($request->password);
            }
            $administrator->save();
            return response()->json(['administrator' => $administrator], 200);
        }
        else{
            return response()->json(['status'=>'У вас нет права изменять добавлять удалять администраторов'], 403);
        }
    }

    public function destroy($id)
    {
        if(Auth::user()->role == 1)
        {
            $administrator = User::find($id)->delete();
            return response()->json(['administrator' => $administrator], 200);
        }
        else{
            return response()->json(['status'=>'У вас нет права изменять добавлять удалять администраторов'], 403);
        }
    }

    public function deleteAll(Request $request)
    {
        if(Auth::user()->role == 1)
        {
            User::whereIn('id', $request->administrators)->delete();
            return response()->json(['status', 'Записи удалены'], 200);
        }
        else{
            return response()->json(['status'=>'У вас нет права изменять добавлять удалять администраторов'], 403);
        }
    }
}
