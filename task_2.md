# Задание 2. Сортировки

## Сортировка чисел

Реализуйте все 3 вида сортировок для целых чисел.

- Сортировка вставками (insertion-sort)
- Рекурсивная сортировка слиянием (merge-sort)

```cpp
#include <vector>

void insertion_sort(std::vector<int>& arr) {
    // TODO: напиши меня
}

void recursive_merge_sort(std::vector<int>& arr) {
    // TODO: напиши меня
}

void merge_sort(std::vector<int>& arr) {
    // TODO: напиши меня
}

int main() {
    // TODO: тут должны быть тесты
    return 0;
}
```

## Сортировка людей

Упорядочить массив Студентов по возрасту и в лексикографическом порядке имен.  
Для этой задачи используйте сортировки из стандартной библиотеки.

```cpp
#include <string>
#include <vector>

struct Student {
    std::string name;
    int age;
}

void sort_students(std::vector<Student>& students) {
    // TODO: напиши меня
}

int main() {
    // Тут должны быть тесты
    return 0;
}
```
