---
layout: page
title: Задание 5. Хеш-таблица
---

# Задание 5. Хеш-таблица

[Шаблон кода на replit](https://replit.com/@IlyaSiganov/0501hashmap#main.cpp)

Реализуйте словарь (он же ассоциативный массив или Map) на основе хеш-таблицы. Для разрешения коллизий используйте метод цепочки: когда в таблице хранятся указатели на связные списки.

Для таблицы используйте `std::vector`, для списка пар `std::list`.

Алгоритм хеширования строк:

```cpp
constexpr size_t P = 300007;  // Размер таблицы. Ближайшее простое > 3*100000
constexpr size_t A = 31;      // Простое и не меньше размера алфавита

size_t hash_str(const std::string& value) {
    size_t h = 0;
    for (char ch : value) {
        h = (h * A + ch) % P;
    }
    return h;
}
```

## Входные данные

На вход программы подаются команды, их количество не превышает 100_000. В каждой строке находится одна из команд:

- `put k v` — сохранить ключ `k` и значение `v` таблицу. Если ключ `k` уже существует, то перезаписать значение на новое `v`.
- `delete k` — удалить ключ k из таблицы и соответсвующее ему значение `v`.
- `get k` — вывести в консоль значение `value` по ключу `k`. Если ключа нет, то вывести строку `null`.

Тип данных `k` и `v` — string. Значения `k` и `v` не соджержат пробельных символов.

Гарантируется, что некорректные команды подаваться НЕ будут.

## Выходные данные

Вывести результаты вызова команд `get`. Каждый результат на новой строке.

## Пример

### Вход

```txt
put hello world
put name ilya
get hello
get ilya
delete hello
get hello
get name
put name vasya
get name
```

### Выход

```txt
world
null
null
ilya
vasya

```
