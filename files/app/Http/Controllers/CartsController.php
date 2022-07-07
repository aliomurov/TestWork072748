<?php

namespace App\Http\Controllers;

use App\Order;
use App\OrderProduct;
use App\Product;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;

class CartsController extends Controller
{
    public function index()
    {
        if(Auth::check())
        {
            $order = auth()->user();
            return response()->json(['order' => $order], 200);
        }
    }

    public function store(Request $request)
    {
        if(Auth::check()){
            $order = Order::create([
                'user_id' => auth()->user()->id,
                'city' => $request->city,
                'address' => $request->address,
                'phone' => $request->phone,
                'total_price' => $request->total_price,
                'check' => 1,
            ]);

            $items = $request->products;
            $data = json_decode($items);
            foreach ($data as $product)
            {
                OrderProduct::create([
                    'order_id' => $order->id,
                    'product_id' => $product->productId,
                    'quantity' => $product->productQuantity,
                ]);
            }

            $products = $order->products;
            foreach ($products as $pro)
            {
                $prod = Product::find($pro->id);
                if (null !== $prod) {
                    $prod->stock = $prod->stock - $pro->pivot->quantity;
                    $prod->save();
                }
            }

            return response()->json(['order' => $order], 200);
        }
    }
}
