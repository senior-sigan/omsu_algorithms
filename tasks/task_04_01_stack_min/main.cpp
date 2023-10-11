#include <iostream>

class StackMin {
 public:
  void push(const int value);
  void pop();
  [[nodiscard]] int top();
  [[nodiscard]] int min();
};

int main() {
  std::ios_base::sync_with_stdio(false);
  std::cin.tie(nullptr);

  StackMin stack;

  std::string cmd;
  while (std::cin >> cmd) {
    if (cmd == "put") {
      int value;
      std::cin >> value;
      stack.push(value);
    } else if (cmd == "top") {
      std::cout << stack.top() << "\n";
    } else if (cmd == "min") {
      std::cout << stack.min() << "\n";
    } else if (cmd == "pop") {
      stack.pop();
    } else {
      std::cout << "Unknown command " << cmd;
      return -1;
    }
  }

  return 0;
}