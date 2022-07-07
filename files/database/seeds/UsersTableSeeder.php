<?php

use App\User;
use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\Hash;

class UsersTableSeeder extends Seeder
{
    public function run()
    {
        User::create([
            'name' => 'Али Омуров',
            'email' => 'admin@mail.ru',
            'role' => 1,
            'password' => bcrypt(123456),
            'api_token' => Hash::make(123456),
        ]);
    }
}
