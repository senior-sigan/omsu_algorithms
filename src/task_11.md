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

- [Простой граф](/assets/task11/simple.zip)
- [Омск](/assets/task11/omsk.zip)

![картанка](https://habrastorage.org/r/w1560/web/7a3/f91/7e2/7a3f917e25b6466b9c228ef3ec8078de.png)

## 1. И пусть весь мир подождёт

Первый спринт разработки. Для начала определитись с форматом хранения базы данных дорог. Научитесь считывать сырые данные и складывать в удобный для вашего алгоритма формат.

<details>
<summary>Код для считывания графа из файла и отрисовки на экране</summary>

Для первого задания вы можете удалить всё связанное с raylib. 

У меня есть шаблон для raylib проекта с cmake: [тут](https://github.com/cat-in-the-dark/cpp_game_template). Но проще всё делать на linux/macos/wsl2 и поставить raylib, как пакет-библиотеку на всю систему.

[Старый стрим про установку Raylib на Macos/Linux](https://www.youtube.com/watch?v=4M0t4ylv-_I)

```cpp
// Команда для компиляции: clang++ -std=c++20 -pedantic -pedantic-errors -Wall  -Wextra $(pkg-config --libs --cflags raylib) main.cpp -o main

#include <fstream>
#include <iomanip>
#include <iostream>
#include <raylib.h>
#include <sstream>
#include <string>
#include <vector>
#include <unordered_map>
#include <cmath>

const int CANVAS_WIDTH = 1200;
const int CANVAS_HEIGHT = 800;

struct Node {
  long id;
  double lon;
  double lat;

  double x;
  double y;

  Node(long id, double lon, double lat) : id(id), lon(lon), lat(lat) {}
};

struct Edge {
  long u;
  long v;

  double ux;
  double uy;

  double vx;
  double vy;

  long dist; // расстояние между u-v

  Edge(long u, long v) : u(u), v(v) {}
};

double eucledean_dist(
  double x1, double y1, double x2, double y2
) {
  return std::sqrt(std::pow(x2 - x1, 2) + std::pow(y1 - y2, 2));
}

std::vector<Node> read_nodes(std::string path) {
  std::fstream csv(path);

  // skip csv header
  std::string header;
  std::getline(csv, header);

  std::vector<Node> nodes;
  // read data
  for (std::string line; std::getline(csv, line);) {
    std::stringstream lineStream(line);
    std::string cell;

    std::getline(lineStream, cell, ',');
    long id = std::stol(cell);

    std::getline(lineStream, cell, ',');
    double lon = std::stod(cell);

    std::getline(lineStream, cell, ',');
    double lat = std::stod(cell);

    nodes.emplace_back(id, lon, lat);
  }

  return nodes;
}

std::vector<Edge> read_edges(std::string path) {
  std::fstream csv(path);

  // skip csv header
  std::string header;
  std::getline(csv, header);

  std::vector<Edge> edges;

  for (std::string line; std::getline(csv, line);) {
    std::stringstream lineStream(line);
    std::string cell;

    std::getline(lineStream, cell, ',');
    long u = std::stol(cell);

    std::getline(lineStream, cell, ',');
    long v = std::stol(cell);

    edges.emplace_back(u, v);
  }

  return edges;
}

int main() {
  auto nodes = read_nodes("omsk/nodes.csv");
  auto edges = read_edges("omsk/edges.csv");

  std::unordered_map<long, std::size_t> node_id_to_pos;
  for (std::size_t i = 0; i < nodes.size(); i++) {
    auto& node = nodes[i];
    node_id_to_pos[node.id] = i;
  }

  std::cout << nodes.size() << std::endl;
  std::cout << edges.size() << std::endl;

  double min_lon = nodes[0].lon;
  double max_lon = nodes[0].lon;
  double min_lat = nodes[0].lat;
  double max_lat = nodes[0].lat;

  for (auto &node : nodes) {
    if (min_lat > node.lat) {
      min_lat = node.lat;
    }
    if (min_lon > node.lon) {
      min_lon = node.lon;
    }
    if (max_lat < node.lat) {
      max_lat = node.lat;
    }
    if (max_lon < node.lon) {
      max_lon = node.lon;
    }
  }

  double delta_lon = max_lon - min_lon;
  double delta_lat = max_lat - min_lat;
  double scale = double(CANVAS_HEIGHT) / std::min(delta_lat, delta_lon);

  std::cout << delta_lon << " " << delta_lat << std::endl;

  std::cout << min_lon << " " << min_lat << "; " << max_lon << " " << max_lat
            << std::endl;

  for (auto& node: nodes) {
    node.x = (node.lon - min_lon) * scale;
    // TODO: костыль, надо перевернуть канвас
    node.y = CANVAS_HEIGHT - ( node.lat - min_lat) * scale;
  }

  for (auto& edge: edges) {
    auto& u = nodes[node_id_to_pos[edge.u]];
    auto& v = nodes[node_id_to_pos[edge.v]]; 
    edge.ux = u.x;
    edge.uy = u.y;
    edge.vx = v.x;
    edge.vy = v.y;

    edge.dist = eucledean_dist(edge.ux, edge.uy, edge.vx, edge.vy);
  }

  InitWindow(CANVAS_WIDTH, CANVAS_HEIGHT, "OMSK");
  SetTargetFPS(60);

  while (!WindowShouldClose()) {
    BeginDrawing();
      ClearBackground(RAYWHITE);
      for (auto& node: nodes) {
        DrawCircle(node.x, node.y, 1.5, RED);
      }
      for (auto& edge: edges) {
        DrawLine(edge.ux, edge.uy, 
                 edge.vx, edge.vy, BLACK);
      }
    EndDrawing();
  }
  CloseWindow();

  return 0;
}
```

</details>

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

- [Лекция в ОмГУ про А* для игр на Lua Love2d](https://www.youtube.com/watch?v=G16xnZJBpFo)
- [habr: Введение в алгоритм A*](https://habr.com/ru/articles/331192/)
- [habr: Реализация алгоритма A*](https://habr.com/ru/articles/331220/)
- [итмо: Алгоритм A*](https://neerc.ifmo.ru/wiki/index.php?title=Алгоритм_A*)
- [wiki: A*](https://ru.wikipedia.org/wiki/A*)
