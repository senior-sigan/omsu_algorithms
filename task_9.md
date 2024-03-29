---
layout: page
title: Задание 9. Деревья поиска
---

# Задание 9. Деревья поиска

## 9.1 Двоичное дерево поиска

Реализуйте простое двоичное дерево поиска. Без балансировки.

### Вход

На вход программы подаются команды, их количество не превышает 100. В каждой строке находится одна из команд:

- `insert x` - добавить в дерево ключ `x`.
- `delete x` - удалить ключ `x` из дерева. Если ключа нет, то ничего делать не нужно.
- `has x` - проверяет, есть ли ключ `x` в дереве. Печатает `t` или `f`.
- `next x` - вывести минимальный элемент дерева, строго больший `x`.
- `prev x` - вывести максимальный элемент дерева, строго меньший `x`.

Все `x` - это целый числа типа `int32`.

### Выход

Результаты выполнения команд `insert`, `has`, `next`, `prev`.

### Пример

**Вход**

```text
insert 5
insert 7
insert 3
insert 4
has 3
has 8
insert 8
has 8
delete 3
has 4
next 7
prev 5
```

**Выход**

```text
t
f
t
t
8
4
```

## 9.2 AVL-дерево

Добавьте баланисровку в дерево из 9.1.

Тесты такие же как и в 9.1.
