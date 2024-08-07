#include <iostream>
#include <string>
#include <vector>

struct Data {
  size_t idx;
  int value;
};

class PriorityQueue {
 public:
  void enqueue(const Data& data);
  void dequeue_max();
  void increase(const Data& data);
  [[nodiscard]] const Data& max() const;
  [[nodiscard]] bool empty() const;
};

int main() {
  std::ios_base::sync_with_stdio(false);
  std::cin.tie(nullptr);

  PriorityQueue queue;

  size_t op_idx = 0;
  std::string cmd;
  while (std::cin >> cmd) {
    if (cmd == "enqueue") {
      op_idx++;
      Data data{op_idx, 0};
      std::cin >> data.value;
      queue.enqueue(data);
    } else if (cmd == "dequeue_max") {
      if (queue.empty()) {
        std::cout << "*\n";
      } else {
        auto& d = queue.max();
        std::cout << d.idx << " " << d.value << "\n";
        queue.dequeue_max();
      }
    } else if (cmd == "inc") {
      Data d{0, 0};
      std::cin >> d.idx >> d.value;
      queue.increase(d);
    } else {
      std::cout << "Unknown command " << cmd;
      return -1;
    }
  }

  return 0;
}