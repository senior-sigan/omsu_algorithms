#include <iostream>
#include <vector>
#include <string>

std::size_t longest_common_subseq(const std::string& seq1, const std::string& seq2) {
  // TODO: напиши меня
  return 0;  // эту строку надо удалить
}

int main() {
  std::ios_base::sync_with_stdio(false);
  std::cin.tie(nullptr);

  std::string seq1;
  std::string seq2;

  std::cin >> seq1;
  std::cin >> seq2;

  auto len = longest_common_subseq(seq1, seq2);

  std::cout << len;

  return 0;
}