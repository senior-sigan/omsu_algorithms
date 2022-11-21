#include <iostream>
#include <vector>

void start(const std::vector<int>& field, std::size_t n, std::size_t m) {
  // TODO: напиши меня!
}

int main() {
  std::ios_base::sync_with_stdio(false);
  std::cin.tie(nullptr);

  std::size_t n, m;
  std::cin >> n >> m;

  std::vector<int> field(n * m);
  for (std::size_t i = 0; i < n; i++) {
    for (std::size_t j = 0; j < m; j++) {
      std::cin >> field.at(i * m + j);
    }
  }

  start(field, n, m);

  return 0;
}