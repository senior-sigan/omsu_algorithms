#include <fstream>
#include <iomanip>
#include <iostream>
#include <raylib.h>
#include <sstream>
#include <string>
#include <vector>
#include <unordered_map>

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
  return 0;
  // TODO:
  //return ((x2 - x1)**2 + (y2 - y1)**2) ** 0.5;
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