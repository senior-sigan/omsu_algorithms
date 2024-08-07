#include <iostream>
#include <vector>

std::vector<int> longest_increasing_subseq(const std::vector<int>& seq) {
  // TODO: напиши меня
  return seq;  // эту строку надо удалить
}

int main() {
  std::ios_base::sync_with_stdio(false);
  std::cin.tie(nullptr);

  std::size_t n;
  std::vector<int> seq(n);

  for (auto& el : seq) {
    std::cin >> el;
  }

  auto longest_seq = longest_increasing_subseq(seq);

  std::cout << longest_seq.size() << "\n";
  for (auto el : longest_seq) {
    std::cout << el << " ";
  }

  return 0;
}