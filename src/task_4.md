---
layout: page
title: Задание 4. Поиск минимумов
---

# Задание 4. Поиск минимумов

## Задание 4.1. Стек минимумов

[Шаблон кода на replit](https://replit.com/@IlyaSiganov/0401stackmin)

Сделать стек на основе односвязного списка, у которого трудоемкость взятие минимума, вставка в стек и удаление из него за `O(1)`.

Связный список надо написать самим.

Операции:

- вставить в конец стека
- удалить последний элемент стека
- выдать минимальный элемент в стеке

### Входные данные

На вход программы подаются команды, их количество не превышает 100_000. В каждой строке находится одна из команд:

- `push k` — положить число k в стек.
- `pop k` — убрать последний элемент в стеке.
- `top` - выдать последний элемент в стеке.
- `min` - выдать текущий минимум в стеке.

Тип данных k — int.

Гарантируется, что некорректные команды подаваться НЕ будут.

### Выходные данные

Вывести результат выполнения команд `top` и `min` в консоль.

### Пример

#### Вход

```text
push 42
top
min
push 12
min
push 13
top
min
pop
pop
min
```

#### Выход

```text
42
42
12
13
12
42
```

### Шаблон кода

```java
public interface MinStack<T extends Number> {
    void push(T value);
    
    T pop();
    
    T top();
    
    T min();
}

// НЕ ДЕЛАЙТЕ это всё в одном файле 🙏🙏🙏

public class MinStackImpl implements MinStack<Integer> {
    @Override
    public void push(Integer value) {
	// TODO
    }

    @Override
    public Integer pop() {
	// TODO
        return null;
    }

    @Override
    public Integer top() {
	// TODO
        return null;
    }

    @Override
    public Integer min() {
	// TODO
        return null;
    }
} 
```

## Задание 4.2 Очередь с приоритетом на основе Кучи

Разработать структуру данных Очередь, выполняющую следующие операции:

1. Вставить в очередь за $O(log(n))$.
2. Извлечь максимальный элемент $O(log(n))$.
3. Увеличить `i-ый` элемент на `v`.

Все операции вставки в очередь вводятся по очереди и нумеруются с 1.

При извлченении элемента из очереди, нужно вывести в стандартый поток вывода сам элемент и номер операции, когда его добавили.

То есть в структуре данных надо хранить само значение элемента и номер операции, когда его добавили.

### Входные данные

На вход программы подаются команды, их количество не превышает 100_000. В каждой строке находится одна из команд:

- `enqueue k` — вставить в очередь число k.
- `dequeue-max` — извлечь из очереди максимальный элемент.
- `inc i v` - найти элемент вставленныей на i-ой операции и увеличить его на v. Если элемента уже нет, то ничего не делать.

Тип данных `k, v` — `Integer`, `i` — `Long`.

Гарантируется, что некорректные команды подаваться НЕ будут.

### Выходные данные

Команда `dequeue-max` печатает в консоль номер операции i, когда элемент был вставлен, и сам элемент `k`.

Если очередь пустая, то печатаем `*`.

### Пример

#### Вход

```text
enqueue 10
enqueue 42
enqueue 9
dequeue-max
inc 3 10
dequeue-max
dequeue-max
dequeue-max
```

#### Выход

```text
2 42
3 19
1 10
*
```

### Шаблон кода

```java
public interface PriorityQueue<T extends Number> {
    void enqueue(T value);
    
    T dequeueMax();
    
    void increment(long operation, T addition);
}

// НЕ ДЕЛАЙТЕ это всё в одном файле 🙏🙏🙏

public class PriorityQueueImpl implements PriorityQueue<Integer> {
    @Override
    public void enqueue(Integer value) {
	// TODO
    }

    @Override
    public Integer dequeueMax() {
	// TODO
        return null;
    }

    @Override
    public void increment(long operation, Integer addition) {
	// TODO
    }
} 
```

