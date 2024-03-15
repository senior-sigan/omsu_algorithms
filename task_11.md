---
layout: page
title: Задание 11. Доставка пиццы
---

![pizza](/assets/pizza.jpeg)

# Доставка пиццы

Вы с друзьями решили запустить стартап по Доставке Пиццы. Рецепты составили, поставщиков ресурсов нашли, в аренду помещения взяли, поваров наняли.

Осталось дело за разработкой алгоритма, который будет находить кратчайший путь от Кухни вашей Пиццерии до клиентов.

У вас есть база данных дорог города, заданной массивом координат перекрестков и связей дорог.

Данные:

- [Простой граф](tasks/task_11_deijkstra/simple.zip)
- [Омск](tasks/task_11_deijkstra/omsk.zip)

![картанка](https://habrastorage.org/r/w1560/web/7a3/f91/7e2/7a3f917e25b6466b9c228ef3ec8078de.png)

## 1. И пусть весь мир подождёт

Первый спринт разработки. Для начала определитись с форматом хранения базы данных дорог. Научитесь считывать сырые данные и складывать в удобный для вашего алгоритма формат.

Далее реализуйте алгоритм Дейкстры для поиска пути.

## 2. Чтобы стоять на месте нужно бежать со всех ног

Отдел поддержки собщает, что доставка не улкадывается в срок "доставить пиццу на за неделю". И проблема не в доставщиках пиццы и не в кухне, а в алгоритме поиска пути. Его надо ускорить!

Реализуйте алгоритм А* для поиска пути.

## 3. Становимся Единорогом

Пользователи хотят видеть маршрут, по которому к ним поедет доставщик.

Реализуйте визуализацию вашего алгоритма. Используйте для этого библиотеку [raylib](https://github.com/raysan5/raylib).

<iframe width="560" height="315" src="https://www.youtube.com/embed/BR4_SrTWbMw?si=g-JGTtbod5qvvzNe" title="YouTube video player" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share" allowfullscreen></iframe>

## Всякие материалы по дорогам и картам

- [OSMNX](https://osmnx.readthedocs.io/en/stable/) - визуализация и загрузка графов дорог на питоне
- [OSMNX туториал](https://geoffboeing.com/2016/11/osmnx-python-street-networks/)
- [Open Street Maps](https://www.openstreetmap.org/export#map=14/54.9800/73.3843)

### Алгоритм А* и Дейкстра

- [habr: Введение в алгоритм A*](https://habr.com/ru/articles/331192/)
- [habr: Реализация алгоритма A*](https://habr.com/ru/articles/331220/)
- [итмо: Алгоритм A*](https://neerc.ifmo.ru/wiki/index.php?title=Алгоритм_A*)
- [wiki: A*](https://ru.wikipedia.org/wiki/A*)
