-- phpMyAdmin SQL Dump
-- version 4.9.0.1
-- https://www.phpmyadmin.net/
--
-- Хост: 127.0.0.1:3306
-- Время создания: Июл 07 2022 г., 13:39
-- Версия сервера: 5.6.43
-- Версия PHP: 7.3.9

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- База данных: `test_work`
--

-- --------------------------------------------------------

--
-- Структура таблицы `blogs`
--

CREATE TABLE `blogs` (
  `id` int(10) UNSIGNED NOT NULL,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `slug` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `url` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `image` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `description` text COLLATE utf8mb4_unicode_ci,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Структура таблицы `categories`
--

CREATE TABLE `categories` (
  `id` int(10) UNSIGNED NOT NULL,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `slug` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Дамп данных таблицы `categories`
--

INSERT INTO `categories` (`id`, `name`, `slug`, `created_at`, `updated_at`) VALUES
(1, 'Курица', 'kuritsa', '2022-07-06 06:43:35', '2022-07-06 06:43:35'),
(2, 'Говядина', 'govyadina', '2022-07-06 06:43:35', '2022-07-06 06:43:35'),
(3, 'Конина', 'konina', '2022-07-06 06:43:35', '2022-07-06 06:43:35'),
(4, 'Баранина', 'baranina', '2022-07-06 06:43:35', '2022-07-06 06:43:35');

-- --------------------------------------------------------

--
-- Структура таблицы `migrations`
--

CREATE TABLE `migrations` (
  `id` int(10) UNSIGNED NOT NULL,
  `migration` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `batch` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Дамп данных таблицы `migrations`
--

INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES
(1, '2014_10_12_000000_create_users_table', 1),
(2, '2014_10_12_100000_create_password_resets_table', 1),
(3, '2020_04_27_114248_create_blogs_table', 1),
(4, '2020_04_29_085101_create_categories_table', 1),
(5, '2020_04_29_093947_create_products_table', 1),
(6, '2020_05_06_103121_create_uploads_table', 1),
(7, '2020_05_09_114225_create_orders_table', 1),
(8, '2020_05_15_133201_create_order_product_table', 1),
(9, '2020_05_21_112352_create_wishes_table', 1),
(10, '2020_05_21_113058_create_product_wish_table', 1);

-- --------------------------------------------------------

--
-- Структура таблицы `orders`
--

CREATE TABLE `orders` (
  `id` int(10) UNSIGNED NOT NULL,
  `user_id` int(10) UNSIGNED DEFAULT NULL,
  `total_price` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `city` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `address` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `phone` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `check` tinyint(1) NOT NULL DEFAULT '0',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Дамп данных таблицы `orders`
--

INSERT INTO `orders` (`id`, `user_id`, `total_price`, `city`, `address`, `phone`, `check`, `created_at`, `updated_at`) VALUES
(1, 1, '800', 'Бишкек', 'dfggfgg', '+996995686897', 2, '2022-07-06 07:08:17', '2022-07-06 07:09:21'),
(2, 1, '40000', 'undefined', 'undefined', 'undefined', 2, '2022-07-06 07:38:19', '2022-07-06 07:38:40');

-- --------------------------------------------------------

--
-- Структура таблицы `order_product`
--

CREATE TABLE `order_product` (
  `id` int(10) UNSIGNED NOT NULL,
  `order_id` int(10) UNSIGNED DEFAULT NULL,
  `product_id` int(10) UNSIGNED DEFAULT NULL,
  `quantity` int(10) UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Дамп данных таблицы `order_product`
--

INSERT INTO `order_product` (`id`, `order_id`, `product_id`, `quantity`, `created_at`, `updated_at`) VALUES
(1, 1, 2, 2, '2022-07-06 07:08:17', '2022-07-06 07:08:17'),
(2, 2, 2, 100, '2022-07-06 07:38:19', '2022-07-06 07:38:19');

-- --------------------------------------------------------

--
-- Структура таблицы `password_resets`
--

CREATE TABLE `password_resets` (
  `email` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Структура таблицы `products`
--

CREATE TABLE `products` (
  `id` int(10) UNSIGNED NOT NULL,
  `category_id` int(10) UNSIGNED DEFAULT NULL,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `slug` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `image` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `price` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `stock` int(11) DEFAULT NULL,
  `unit` tinyint(1) NOT NULL DEFAULT '0',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Дамп данных таблицы `products`
--

INSERT INTO `products` (`id`, `category_id`, `name`, `slug`, `image`, `price`, `stock`, `unit`, `created_at`, `updated_at`) VALUES
(1, 1, 'Мякоть говяжья внутренней части отруба в/у кг', 'myakot-govyazhya-vnutrenney-chasti-otruba-vu-kg', 'products/100030213751b0_2.jpg', '350', 1000, 2, '2022-07-06 06:43:35', '2022-07-06 07:28:12'),
(2, 1, 'Говядина Мраморная для Стейка фланк охлаждённая (choice) б/к в/у кг', 'govyadina-mramornaya-dlya-steyka-flank-okhlazhdennaya-choice-bk-vu-kg', 'products/100030213751b0.jpg', '400', 1898, 2, '2022-07-06 06:43:35', '2022-07-06 07:38:19'),
(3, 1, 'Говядина Мраморная Пиканья охлаждённая б/к в/у (choice) кг', 'govyadina-mramornaya-pikanya-okhlazhdennaya-bk-vu-choice-kg', 'products/100030213751b0_1.jpg', '280', 2000, 2, '2022-07-06 06:43:35', '2022-07-06 07:28:09'),
(4, 3, 'Говядина Мраморная Пиканья охлаждённая', 'govyadina-mramornaya-pikanya-okhlazhdennaya', 'products/100030213751b0_3.jpg', '550', 500, 2, '2022-07-06 07:39:19', '2022-07-06 07:39:19');

-- --------------------------------------------------------

--
-- Структура таблицы `product_wish`
--

CREATE TABLE `product_wish` (
  `id` int(10) UNSIGNED NOT NULL,
  `wish_id` int(10) UNSIGNED DEFAULT NULL,
  `product_id` int(10) UNSIGNED DEFAULT NULL,
  `quantity` int(10) UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Структура таблицы `uploads`
--

CREATE TABLE `uploads` (
  `id` int(10) UNSIGNED NOT NULL,
  `product_id` int(10) UNSIGNED NOT NULL,
  `images` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Структура таблицы `users`
--

CREATE TABLE `users` (
  `id` int(10) UNSIGNED NOT NULL,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `name_company` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `phone_company` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `type_company` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `teams_company` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `city_company` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `address_company` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `email` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email_verified_at` timestamp NULL DEFAULT NULL,
  `password` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `role` tinyint(1) DEFAULT '0',
  `api_token` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `remember_token` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Дамп данных таблицы `users`
--

INSERT INTO `users` (`id`, `name`, `name_company`, `phone_company`, `type_company`, `teams_company`, `city_company`, `address_company`, `email`, `email_verified_at`, `password`, `role`, `api_token`, `remember_token`, `created_at`, `updated_at`) VALUES
(1, 'Али Омуров', NULL, NULL, NULL, NULL, NULL, NULL, 'admin@mail.ru', NULL, '$2y$10$zcM4c1AYhbmD9p7CmFuOnecYBEpyHCtEUpZGq7v4DgS/j0hOZrHIm', 1, 'wnSjuKjTJizAPjktRrSJSPiExaOqiuc5TMwG8x8Ra4PPKDV8AGiOjW0OAiJIJtNlAMzKQ8DIPaF7G05A', NULL, '2022-07-06 06:43:35', '2022-07-06 07:07:34'),
(2, 'Самат Нурматов', 'Акслайт груп', '0777 77 77 77', 'Кафе', NULL, 'Бишкек', 'Токтогула Советская 148', 'samat@mail.ru', NULL, '$2y$10$yZCXI7UT4ggIhuRjIya0OuPWfXuXsBQNVIfJDB0L7l1vYPU6l9eqa', 0, NULL, NULL, '2022-07-06 06:43:35', '2022-07-06 06:43:35'),
(3, 'Саркобенов Улан', 'Строй холдинг', '0770 996 770', 'Пансионат', NULL, 'Ыссык-Кол', 'Село Туп', 'ulan@mail.ru', NULL, '$2y$10$QRb/Qt93oX9BGyN/45MMy.kmWMPv8bEzc6JLV3j8If1Qo62icGgDm', 0, NULL, NULL, '2022-07-06 06:43:35', '2022-07-06 06:43:35'),
(4, 'Азамат Ибраев', 'Бизнес студио', '0555 55 55 55', 'Ресторан', NULL, 'Бишкек', 'Токтогула Советская 148', 'azamat@mail.ru', NULL, '$2y$10$YzBQ2HuhfYsHE2UOTvhcS.89ynjgxHqgFoLnSbhEWT.Woqs5hjYXu', 0, NULL, NULL, '2022-07-06 06:43:35', '2022-07-06 06:43:35');

-- --------------------------------------------------------

--
-- Структура таблицы `wishes`
--

CREATE TABLE `wishes` (
  `id` int(10) UNSIGNED NOT NULL,
  `user_id` int(10) UNSIGNED DEFAULT NULL,
  `monday` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `tuesday` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `wednesday` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `thursday` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `friday` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `saturday` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `sunday` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `total_price` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Индексы сохранённых таблиц
--

--
-- Индексы таблицы `blogs`
--
ALTER TABLE `blogs`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `categories`
--
ALTER TABLE `categories`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `migrations`
--
ALTER TABLE `migrations`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `orders`
--
ALTER TABLE `orders`
  ADD PRIMARY KEY (`id`),
  ADD KEY `orders_user_id_foreign` (`user_id`);

--
-- Индексы таблицы `order_product`
--
ALTER TABLE `order_product`
  ADD PRIMARY KEY (`id`),
  ADD KEY `order_product_order_id_foreign` (`order_id`),
  ADD KEY `order_product_product_id_foreign` (`product_id`);

--
-- Индексы таблицы `password_resets`
--
ALTER TABLE `password_resets`
  ADD KEY `password_resets_email_index` (`email`);

--
-- Индексы таблицы `products`
--
ALTER TABLE `products`
  ADD PRIMARY KEY (`id`),
  ADD KEY `products_category_id_foreign` (`category_id`);

--
-- Индексы таблицы `product_wish`
--
ALTER TABLE `product_wish`
  ADD PRIMARY KEY (`id`),
  ADD KEY `product_wish_wish_id_foreign` (`wish_id`),
  ADD KEY `product_wish_product_id_foreign` (`product_id`);

--
-- Индексы таблицы `uploads`
--
ALTER TABLE `uploads`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `uploads_images_unique` (`images`),
  ADD KEY `uploads_product_id_foreign` (`product_id`);

--
-- Индексы таблицы `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `users_email_unique` (`email`),
  ADD UNIQUE KEY `users_api_token_unique` (`api_token`);

--
-- Индексы таблицы `wishes`
--
ALTER TABLE `wishes`
  ADD PRIMARY KEY (`id`),
  ADD KEY `wishes_user_id_foreign` (`user_id`);

--
-- AUTO_INCREMENT для сохранённых таблиц
--

--
-- AUTO_INCREMENT для таблицы `blogs`
--
ALTER TABLE `blogs`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT для таблицы `categories`
--
ALTER TABLE `categories`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT для таблицы `migrations`
--
ALTER TABLE `migrations`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT для таблицы `orders`
--
ALTER TABLE `orders`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT для таблицы `order_product`
--
ALTER TABLE `order_product`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT для таблицы `products`
--
ALTER TABLE `products`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT для таблицы `product_wish`
--
ALTER TABLE `product_wish`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT для таблицы `uploads`
--
ALTER TABLE `uploads`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT для таблицы `users`
--
ALTER TABLE `users`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT для таблицы `wishes`
--
ALTER TABLE `wishes`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- Ограничения внешнего ключа сохраненных таблиц
--

--
-- Ограничения внешнего ключа таблицы `orders`
--
ALTER TABLE `orders`
  ADD CONSTRAINT `orders_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE SET NULL ON UPDATE CASCADE;

--
-- Ограничения внешнего ключа таблицы `order_product`
--
ALTER TABLE `order_product`
  ADD CONSTRAINT `order_product_order_id_foreign` FOREIGN KEY (`order_id`) REFERENCES `orders` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `order_product_product_id_foreign` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`) ON DELETE SET NULL ON UPDATE CASCADE;

--
-- Ограничения внешнего ключа таблицы `products`
--
ALTER TABLE `products`
  ADD CONSTRAINT `products_category_id_foreign` FOREIGN KEY (`category_id`) REFERENCES `categories` (`id`) ON DELETE CASCADE;

--
-- Ограничения внешнего ключа таблицы `product_wish`
--
ALTER TABLE `product_wish`
  ADD CONSTRAINT `product_wish_product_id_foreign` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `product_wish_wish_id_foreign` FOREIGN KEY (`wish_id`) REFERENCES `wishes` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Ограничения внешнего ключа таблицы `uploads`
--
ALTER TABLE `uploads`
  ADD CONSTRAINT `uploads_product_id_foreign` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`) ON DELETE CASCADE;

--
-- Ограничения внешнего ключа таблицы `wishes`
--
ALTER TABLE `wishes`
  ADD CONSTRAINT `wishes_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE SET NULL ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
