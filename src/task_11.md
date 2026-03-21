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

Первый спринт разработки. Для начала определитесь с форматом хранения базы данных дорог. Научитесь считывать сырые данные и складывать в удобный для вашего алгоритма формат.

<details>
<summary>Код для считывания графа из файла</summary>

Это лишь небольшой шаблон того, с чего можно начать, при желании доработайте его под свои нужды

Файл Node.java
```java
public class Node {
  private final long id;
  private final double lon;
  private final double lat;
  private double x;
  private double y;
  
  public Node(long id, double lon, double lat) {
    this.id = id;
    this.lon = lon;
    this.lat = lat;
  }
  
  public long getId() {
    return id;
  }
  
  public double getLon() {
    return lon;
  }
  
  public double getLat() {
    return lat;
  }
  
  public double getX() {
    return x;
  }
  
  public void setX(double x) {
    this.x = x;
  }
  
  public double getY() {
    return y;
  }
  
  public void setY(double y) {
    this.y = y;
  }
}
```

Файл Edge.java
```java
public class Edge {
  private final long u;
  private final long v;
  private double ux;
  private double uy;
  private double vx;
  private double vy;
  private long distance; // расстояние между u-v
  
  public Edge(long u, long v) {
    this.u = u;
    this.v = v;
  }
  
  public long getU() {
    return u;
  }
  
  public long getV() {
    return v;
  }
  
  public double getUx() {
    return ux;
  }
  
  public void setUx(double ux) {
    this.ux = ux;
  }
  
  public double getUy() {
    return uy;
  }
  
  public void setUy(double uy) {
    this.uy = uy;
  }
  
  public double getVx() {
    return vx;
  }
  
  public void setVx(double vx) {
    this.vx = vx;
  }
  
  public double getVy() {
    return vy;
  }
  
  public void setVy(double vy) {
    this.vy = vy;
  }
  
  public long getDistance() {
    return distance;
  }
  
  public void setDistance(long distance) {
    this.distance = distance;
  }
}
```

Тут мы инкапсулируем считывание данных из файла. Напоминаю, это только шаблон, feel free to доработать этот код под себя, изменить или вообще написать совсем по-своему.

Файл MapFileReaderUtils.java
```java
import java.io.BufferedReader;
import java.io.FileReader;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

public class MapFileReaderUtils {
  public static List<Node> readNodes(String filePath) throws IOException {
    List<Node> nodes = new ArrayList<>();
    
    try (BufferedReader br = new BufferedReader(new FileReader(filePath))) {
      String line = br.readLine();
      while ((line = br.readLine()) != null) {
        if (line.isEmpty()) {
          continue;
        }
        
        String[] cells = line.split(",");
        if (cells.length >= 3) {
          long id = Long.parseLong(cells[0].trim());
          double lon = Double.parseDouble(cells[1].trim());
          double lat = Double.parseDouble(cells[2].trim());
          nodes.add(new Node(id, lon, lat));
        }
      }
    }
    return nodes;
  }
  
  public static List<Edge> readEdges(String filePath) throws IOException {
    List<Edge> edges = new ArrayList<>();
    
    try (BufferedReader br = new BufferedReader(new FileReader(filePath))) {
      String line = br.readLine();
      while ((line = br.readLine()) != null) {
        if (line.isEmpty()) {
          continue;
        }
        
        String[] cells = line.split(",");
        if (cells.length >= 2) {
          long u = Long.parseLong(cells[0].trim());
          long v = Long.parseLong(cells[1].trim());
          edges.add(new Edge(u, v));
        }
      }
    }
    return edges;
  }
}
```

Файл DistanceUtils.java

Допустим, вынесем вычисление дистанций вот так 
```java
import java.util.*;

public class DistanceUtils {
  public static double euclideanDistance(double x1, double y1, double x2, double y2) {
    return Math.sqrt(Math.pow(x2 - x1, 2) + Math.pow(y1 - y2, 2));;
  }
}
```

Main.java

Что-то вроде такого
```java
import java.util.*;

public class Main {
    public static void main(String[] args) {
        List<Node> nodes = MapFileReaderUtils.readNodes("omsk/nodes.csv");
        List<Edge> edges = MapFileReaderUtils.readEdges("omsk/edges.csv");

        Map<Long, Integer> nodePositionsByNodeId = new HashMap<>();
        for (int i = 0; i < nodes.size(); i++) {
            nodePositionsByNodeId.put(nodes.get(i).getId(), i);
        }

        for (Edge edge : edges) {
            Node u = nodes.get(nodePositionsByNodeId.get(edge.getU()));
            Node v = nodes.get(nodePositionsByNodeId.get(edge.getV()));

            edge.setUx(u.getX());
            edge.setUy(u.getY());
            edge.setVx(v.getX());
            edge.setVy(v.getY());
            edge.setDistance(DistanceUtils.euclideanDistance(edge.getUx(), edge.getUy(), edge.getVx(), edge.getVy()));
        }
    }
}
```

</details>

Далее реализуйте алгоритм Дейкстры для поиска пути.

Сделайте отдельный интерфейс `RouteBuilder` примерно такого вида
```java
import java.util.List;

public interface RouteBuilder {
  List<Edge> createRoute(Node start, Node finish);
}
```

Под реализацию Дейкстры сделайте класс `DijkstraRouteBuilder`, реализующий этот интерфейс, с реализацией алгоритма.

## 2. Чтобы стоять на месте нужно бежать со всех ног

Отдел поддержки собщает, что доставка не улкадывается в срок "доставить пиццу н за неделю". И проблема не в доставщиках пиццы и не в кухне, а в алгоритме поиска пути. Его надо ускорить!

Реализуйте алгоритм А* для поиска пути.

Под реализацию A* сделайте класс `AStarRouteBuilder`, реализующий интерфейс `RouteBuilder`, с реализацией алгоритма.

## 3. To See the World...

Пользователи хотят видеть маршрут, по которому к ним поедет доставщик.

Реализуйте визуализацию вашего алгоритма. Используйте для этого библиотеку [libGDX](https://libgdx.com/dev/). 

Есть описание создания простого проекта с этой библиотекой [вот здесь](https://libgdx.com/wiki/start/setup), [тут](https://libgdx.com/wiki/start/demos-and-tutorials) есть небольшие туториалы. Помимо туториалов (не только этих) воспользуйтесь нейронками, 2026 год как-никак Sadge.

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

