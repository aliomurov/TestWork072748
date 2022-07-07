<?php
Route::get('/', 'PagesController@index');
Route::get('/catalog', 'PagesController@catalog');
Route::get('/catalog/{id}', 'PagesController@category');
Route::post('/login', 'PagesController@login');
Route::post('/register/store', 'PagesController@company');

Route::group(['middleware'=> ['auth:api']], function () {
    Route::get('verify', 'PagesController@verify');

    Route::get('checkout', 'CartsController@index');
    Route::post('checkout/store', 'CartsController@store');

    Route::get('profile', 'PagesController@profile');
    Route::get('profile/order/{id}', 'PagesController@profileOrder');
    Route::post('profile/update/{id}', 'PagesController@profileUpdate');
});

Route::group(['middleware'=> ['auth:api'], 'namespace'=>'Api'], function () {
    Route::group(['prefix' => 'admin'], function(){
        Route::get('verify', 'LoginController@verify');

        Route::resource('/', 'PagesController');

        Route::resource('administrators', 'AdministratorsController');
        Route::group(['prefix' => 'administrators'], function(){
            Route::post('delete', 'AdministratorsController@deleteAll');
            Route::get('edit/{id}', 'AdministratorsController@edit');
            Route::post('update/{id}', 'AdministratorsController@update');
        });

        Route::resource('categories', 'CategoriesController');
        Route::group(['prefix' => 'categories'], function(){
            Route::get('edit/{id}', 'CategoriesController@edit');
            Route::post('update/{id}', 'CategoriesController@update');
            Route::post('delete', 'CategoriesController@deleteAll');
        });

        Route::resource('products', 'ProductsController');
        Route::group(['prefix' => 'products'], function(){
            Route::post('/import', 'ProductsController@import');
            Route::post('image', 'ProductsController@changeImage');
            Route::post('images', 'ProductsController@images');
            Route::post('delete', 'ProductsController@deleteAll');
            Route::get('create', 'ProductsController@create');
            Route::get('edit/{id}', 'ProductsController@edit');
            Route::post('update/{id}', 'ProductsController@update');
        });

        Route::resource('uploads', 'UploadsController');

        Route::resource('orders', 'OrdersController');
        Route::group(['prefix' => 'orders'], function(){
            Route::get('edit/{id}', 'OrdersController@edit');
            Route::post('update/{id}', 'OrdersController@update');
            Route::post('delete', 'OrdersController@deleteAll');
        });
    });
});

Route::post('admin/login', 'Api\LoginController@login')->name('login');
