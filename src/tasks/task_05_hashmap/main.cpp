#include <iostream>
#include <list>
#include <string>
#include <vector>

class HashMap {
 public:
  void put(const std::string& key, const std::string& value);
  [[nodiscard]] std::string get(const std::string& key);
  void erase(const std::string& key);
};

int main() {
  std::ios_base::sync_with_stdio(false);
  std::cin.tie(nullptr);

  HashMap map;

  std::string cmd;
  while (std::cin >> cmd) {
    if (cmd == "put") {
      std::string x;
      std::string y;
      std::cin >> x >> y;
      map.put(x, y);
    } else if (cmd == "get") {
      std::string x;
      std::cin >> x;
      std::cout << map.get(x) << "\n";
    } else if (cmd == "delete") {
      std::string x;
      std::cin >> x;
      map.erase(x);
    } else {
      std::cout << "Unknown command " << cmd;
      return -1;
    }
  }

  return 0;
}