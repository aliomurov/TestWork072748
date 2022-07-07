<?php

namespace App\Imports;

use App\Product;
use Maatwebsite\Excel\Concerns\ToModel;

class ProductsImport implements ToModel
{
    public function model(array $row)
    {
        return new Product([
            'name' => $row[1],
            'category_id' => $row[2],
            'price' => $row[3],
            'stock' => $row[4],
            'unit' => $row[5],
            'image' => $row[6],
        ]);
    }
}
