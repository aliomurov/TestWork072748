<?php

namespace App\Http\Controllers\Api;

use App\Category;
use App\Exports\ProductsExport;
use App\Helpers\Image;
use App\Imports\ProductsImport;
use App\Order;
use App\Product;
use App\Upload;
use Illuminate\Http\Request;
use App\Http\Controllers\Controller;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Storage;
use Maatwebsite\Excel\Facades\Excel;

class ProductsController extends Controller
{
    public function index(Request $request)
    {
        if(Auth::user()->role === 1){
            $per_page = $request->per_page ? $request->per_page: 5;
            $sortBy = $request->sort_by;
            $orderBy = $request->order_by;
            return response()->json([
                'products' => Product::with('category')->orderBy($sortBy, $orderBy)->paginate($per_page)
            ], 200);
        }
        else{
            return response()->json([], 401);
        }
    }

    public function show($id)
    {
        $products = Product::where('name', 'LIKE', "%$id%")->paginate();
        return response()->json(['products' => $products], 200);
    }

    public function create()
    {
        $categories = Category::all();
        return response()->json(['categories' => $categories], 200);
    }

    public function store(Request $request)
    {
        if (Product::where('name', '=', $request->name)->exists())
        {
            return response()->json(['status'=>'Такой продукты уже существует'], 403);
        }

        if($request->image){
            $image = Image::store('products', $request->image);
        }

        $product = Product::create([
            'name' => $request->name,
            'price' => $request->price,
            'stock' => $request->stock,
            'unit' => $request->unit,
            'image' => $image,
            'category_id' => $request->category_id,
        ]);

        if($request->file('files'))
        {
            $files = $request->file('files');

            foreach ($files as $file)
            {
                $file = Image::store('uploadsProduct', $file);
                Upload::create([
                    'images' => $file,
                    'product_id' => $product->id,
                ]);
            }
        }

        return response()->json(['product' => $product], 200);
    }

    public function edit($id)
    {
        $product = Product::with('category')->find($id);
        $files = Upload::get();
        $categories = Category::all();
        return response()->json(['product' => $product, 'categories' => $categories, 'files' => $files], 200);
    }

    public function update(Request $request, $id)
    {
        $product = Product::find($id);
        $product->name = $request->name;
        $product->price = $request->price;
        $product->stock = $request->stock;
        $product->category_id = $request->category_id;
        $product->unit = $request->unit;
        $product->save();

        return response()->json(['product' => $product], 200);
    }

    public function changeImage(Request $request)
    {
        $product = Product::find($request->product);
        if($request->image){
            Storage::delete($product->image);
            $image = Image::store('products', $request->image);
        }
        if($request->image){
            $product->image = $image;
        }
        $product->save();
        return response()->json(['product' => $product], 200);
    }

    public function images(Request $request)
    {
        if($request->file('images'))
        {
            $images = $request->file('images');
            foreach ($images as $image)
            {
                $image = Image::store('uploadsProduct', $image);
                Upload::create([
                    'images' => $image,
                    'product_id' => $request->id,
                ]);
            }
        }
    }

    public function destroy($id)
    {
        $ass = Product::find($id);
        Storage::delete($ass->image);
        $product = Product::find($id)->delete();
        return response()->json(['product' => $product], 200);
    }

    public function deleteAll(Request $request)
    {
        Product::whereIn('id', $request->products)->delete();
        return response()->json(['status', 'Записи удалены'], 200);
    }

    public function import(Request $request)
    {
        $products = Excel::toCollection(new ProductsImport, $request->file('import_file'));
        foreach($products[0] as $product){
            if(!$product[0]){
                Product::create([
                    'name' => $product[1],
                    'category_id' => $product[2],
                    'price' => $product[3],
                    'stock' => $product[4],
                    'unit' => $product[5],
                    'image' => $product[6],
                ]);
            } else {
                Product::where('id', $product[0])->update([
                    'name' => $product[1],
                    'category_id' => $product[2],
                    'price' => $product[3],
                    'stock' => $product[4],
                    'unit' => $product[5],
                    'image' => $product[6],
                ]);
            }
        }

        return response()->json(['products' => $products]);
    }
}
