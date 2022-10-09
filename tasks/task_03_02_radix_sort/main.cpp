#include <iostream>
#include <vector>

void radix_sort(std::vector<std::string>& arr) {
  // TODO: напиши меня!
}

int main() {
  std::ios_base::sync_with_stdio(false);
  std::cin.tie(nullptr);

  size_t n;
  std::cin >> n;

  std::vector<std::string> lines(n);
  for (auto& line : lines) {
    std::cin >> line;
  }

  radix_sort(lines);

  for (const auto& line : lines) {
    std::cout << line << "\n";
  }

  return 0;
}