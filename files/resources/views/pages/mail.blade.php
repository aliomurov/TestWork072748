<!doctype html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport"
          content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>Заявка с Мясной лавки - {{$order->price}}</title>
</head>
<body>
<h2>Заявка с Мясной лавки - {{$order->price}}</h2>

<b>ФИО заказчика: </b>{{$order->name}} <br>
<b>Телефон заказчика:</b> {{$order->phone}} <br>
<b>Услуга:</b> {{$order->price}}<br>
</body>
</html>
