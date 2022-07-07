<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Order;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;

class OrdersController extends Controller
{
    public function index(Request $request)
    {
        if(Auth::user()->role === 1){
            $per_page = $request->per_page ? $request->per_page: 5;
            $orders = Order::with('user')->orderBy('check', 'asc')->paginate($per_page);
            return response()->json(['orders' =>  $orders], 200);
        }
        else{
            return response()->json([], 401);
        }
    }

    public function edit($id)
    {
        $order = Order::with('user')->find($id);
        $products = $order->products;
        return response()->json(['order' => $order, 'products' => $products], 200);
    }

    public function update(Request $request, $id)
    {
        $order = Order::find($id);
        $order->check = $request->check;
        $order->save();

        return response()->json(['order' => $order], 200);
    }

    public function destroy($id)
    {
        $order = Order::find($id)->delete();
        return response()->json(['order' => $order], 200);
    }

    public function deleteAll(Request $request)
    {
        Order::whereIn('id', $request->orders)->delete();
        return response()->json(['status', 'Записи удалены'], 200);
    }
}
