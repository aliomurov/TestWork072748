<?php

namespace App\Http\Controllers\Api;

use App\Category;
use Illuminate\Http\Request;
use App\Http\Controllers\Controller;
use Illuminate\Support\Facades\Auth;

class CategoriesController extends Controller
{
    public function index(Request $request)
    {
        if(Auth::user()->role === 1){
            $per_page = $request->per_page ? $request->per_page: 5;
            return response()->json(['categories' => Category::paginate($per_page) ], 200);
        }
        else{
            return response()->json([], 401);
        }
    }

    public function show($id)
    {
        $categories = Category::where('name', 'LIKE', "%$id%")->paginate();
        return response()->json(['categories' => $categories], 200);
    }

    public function store(Request $request)
    {
        if (Category::where('name', '=', $request->name)->exists())
        {
            return response()->json(['status'=>'Такая категория уже существует'], 403);
        }

        $category = Category::create([
            'name' => $request->name,
        ]);

        return response()->json(['category' => $category], 200);
    }

    public function edit($id)
    {
        $category = Category::find($id);
        return response()->json(['category' => $category], 200);
    }

    public function update(Request $request, $id)
    {
        $category = Category::find($id);
        $category->name = $request->name;
        $category->save();

        return response()->json(['category' => $category], 200);
    }

    public function changeUpdate(Request $request)
    {
        $category = Category::find($request->category);
        $category->name = $request->name;
        $category->save();
        return response()->json(['category' => $category], 200);
    }

    public function destroy($id)
    {
        $category = Category::find($id)->delete();
        return response()->json(['category' => $category], 200);
    }

    public function deleteAll(Request $request)
    {
        Category::whereIn('id', $request->categories)->delete();
        return response()->json(['status', 'Записи удалены'], 200);
    }
}
