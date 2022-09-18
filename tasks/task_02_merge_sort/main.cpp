#include <vector>
#include <iostream>

void merge(std::vector<int>& arr, std::vector<int>& buffer, size_t begin, size_t middle, size_t end) {
    // TODO: напишите слияние двух отсортированных массивов
}

void merge_sort(std::vector<int>& arr, std::vector<int>& buffer, size_t begin, size_t end) {
    // TODO: напишите merge_sort (ваш Кэп!)
}

void run_merge_sort(std::vector<int>& arr) {
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

  run_merge_sort(arr);

  for (auto i : arr) {
    std::cout << i << " ";
  }

  return 0;
}