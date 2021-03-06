<?php

use App\Category;
use Illuminate\Database\Seeder;

class CategoriesTableSeeder extends Seeder
{
    /**
     * Run the database seeds.
     *
     * @return void
     */
    public function run()
    {
        Category::create([
            'name' => 'Курица',
        ]);

        Category::create([
            'name' => 'Говядина',
        ]);

        Category::create([
            'name' => 'Конина',
        ]);

        Category::create([
            'name' => 'Баранина',
        ]);
    }
}
