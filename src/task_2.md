---
layout: page
title: Задание 2. Сортировки
---

# Задание 2. Сортировки

[Теория](/theory/sort)

## 2.1 Сортировка вставками (Insertions sort)

Дан массив чисел. Отсортировать в порядке возрастания алгоритмом сортировки вставками.

### Входные данные

Входные данные подаются на System.in.

В первой строке содержится число N (1 <= N <=100000) — количество элементов в массиве.
Во второй строке находятся N целых чисел, по модулю не превосходящих 10^9.

```txt
10
1 2 5 1 1 2 6 8 9 3
```

### Выходные данные

В System.out вывести отсортированный массив числе по возрастанию через пробел.

```txt
1 1 1 2 2 3 5 6 8 9
```

### Шаблон кода

```java
import java.util.List;

// Этот интерфейс будет общим для всех остальных сортировок
public interface Sortable<T extends Comparable<T>> {
    void sort(List<T> nums);
}

// НЕ ДЕЛАЙТЕ это всё в одном файле 🙏🙏🙏

import java.util.List;

public class InsertionSort implements Sortable<Integer> {
    @Override
    public void sort(List<Integer> nums) {
	// TODO
    }
}
```

## 2.2 Сортировка слиянием (Merge sort)

Дан массив чисел. Отсортировать в порядке возрастания алгоритмом сортировки слиянием.

### Входные данные

Входные данные подаются на System.in.

В первой строке содержится число N (1 <= N <=100000) — количество элементов в массиве.
Во второй строке находятся N целых чисел, по модулю не превосходящих 10^9.

```txt
10
1 2 5 1 1 2 6 8 9 3
```

### Выходные данные

В System.out вывести отсортированный массив числе по возрастанию через пробел.

```txt
1 1 1 2 2 3 5 6 8 9
```

### Шаблон кода

```java
import java.util.List;

public class MergeSort implements Sortable<Integer> {
    private void slice(List<Integer> nums, int start, int end) {
	// TODO
    }

    private void merge(List<Integer> nums, int start, int middle, int end) {
	// TODO
    }

    @Override
    public void sort(List<Integer> nums) {
	slice(nums, 0, nums.size() - 1);
    }
}
```

## 2.3 Сортировка структур

Упорядочить массив Студентов по возрастанию возраста и в лексикографическом порядке имен, применив сортировку дважды.
В варианте на C++ можно было воспользоваться сортировками из стандартной библиотеки, для Java вам придётся реализовать их самостоятельно. Найдите, какие сортировки являются стабильными и нестабильными и реализуйте их.

### Входные данные

Входные данные подаются на System.in.

В первой строке содержится число N (1 <= N <=100000) — количество элементов в массиве.
Далее N строк. В каждой строке сначала идет строка — имя студента, и через пробел чисдло — возраст студента.

```txt
4
Vasya 21
Vasya 19
Anton 22
Antonio 23
```

### Выходные данные

В System.out вывести отсортированный массив студентов. Каждый студент на новой строке. Сначала имя, потом возраст через пробел.

```txt
Anton 22
Antonio 23
Vasya 19
Vasya 21
```

### Шаблон кода

```java
public class Student {
    private final String name;
    private final int age;

    public Student(String name, int age) {
        this.name = name;
        this.age = age;
    }

    public String getName() {
        return name;
    }

    public int getAge() {
        return age;
    }
}

// НЕ ДЕЛАЙТЕ это всё в одном файле 🙏🙏🙏

import java.util.List;

public class StudentSort implements Sortable<Student> {
    @Override
    public void sort(List<Student> students) {
	// TODO
    }
}
```

