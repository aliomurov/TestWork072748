<?php

use App\Product;
use Illuminate\Database\Seeder;

class ProductsTableSeeder extends Seeder
{
    /**
     * Run the database seeds.
     *
     * @return void
     */
    public function run()
    {
        Product::create([
            'name' => 'Мякоть говяжья внутренней части отруба в/у кг',
            'category_id' => '1',
            'image' => 'products/luk.jpg',
            'price' => '350',
            'stock' => '1000',
            'unit' => '2',
        ]);

        Product::create([
            'name' => 'Говядина Мраморная для Стейка фланк охлаждённая (choice) б/к в/у кг',
            'category_id' => '1',
            'image' => 'products/kartoshka.jpg',
            'price' => '400',
            'stock' => '2000',
            'unit' => '2',
        ]);

        Product::create([
            'name' => 'Говядина Мраморная Пиканья охлаждённая б/к в/у (choice) кг',
            'category_id' => '1',
            'image' => 'products/chesnok.jpg',
            'price' => '280',
            'stock' => '2000',
            'unit' => '2',
        ]);
    }
}
