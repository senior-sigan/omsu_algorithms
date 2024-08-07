#include <algorithm>
#include <iostream>
#include <string>
#include <vector>

struct Student {
  std::string name;
  int age;
};

void sort_students(std::vector<Student> &arr) {
  // TODO: напиши меня!
}

int main() {
  std::ios_base::sync_with_stdio(false);
  std::cin.tie(nullptr);

  size_t n;
  std::cin >> n;

  std::vector<Student> arr(n);
  for (auto &el : arr) {
    std::cin >> el.name;
    std::cin >> el.age;
  }

  sort_students(arr);

  for (auto el : arr) {
    std::cout << el.name << " " << el.age << "\n";
  }

  return 0;
}