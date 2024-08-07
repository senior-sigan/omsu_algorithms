#include <iostream>
#include <vector>

void count_sort(std::vector<int> &arr) {
  // TODO: напиши меня!
}

int main() {
  std::ios_base::sync_with_stdio(false);
  std::cin.tie(nullptr);

  size_t n;
  std::cin >> n;

  std::vector<int> arr(n);
  for (size_t i = 0; i < n; i++) {
    std::cin >> arr[i];
  }

  count_sort(arr);

  for (auto i : arr) {
    std::cout << i << " ";
  }

  return 0;
}