---
layout: page
title: Задание 5. Хеш-таблица
---

# Задание 5. Хеш-таблица

Реализуйте словарь (он же ассоциативный массив или Map) на основе хеш-таблицы. Для разрешения коллизий используйте метод цепочки: когда в таблице хранятся указатели на связные списки.

Для таблицы используйте `ArrayList`, для списка пар `LinkedList`.

## Входные данные

На вход программы подаются команды, их количество не превышает 100_000. В каждой строке находится одна из команд:

- `put k v` — сохранить ключ `k` и значение `v` таблицу. Если ключ `k` уже существует, то перезаписать значение на новое `v`.
- `delete k` — удалить ключ k из таблицы и соответсвующее ему значение `v`.
- `get k` — вывести в консоль значение `v` по ключу `k`. Если ключа нет, то вернуть `null`.

Тип данных `k` и `v` — String. Значения `k` и `v` не соджержат пробельных символов.

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

### Шаблон кода

```java
public interface HashMap<K, V> {
    /**
     * Сохраняет ключ key и значение value таблицу.
     * Если ключ key уже существует, то перезаписать значение на новое value.
     *
     * @param key   ключ для сохранения
     * @param value значение для сохранения
     */
    void put(K key, V value);

    /**
     * Вернуть значение по ключу.
     *
     * @param key ключ для поиска
     * @return найденное значение или null, если ничего не найдено
     */
    V getValue(K key);

    /**
     * Удалить значение по ключу.
     *
     * @param key ключ для поиска
     * @return удалённое значение или null, если ничего не найдено
     */
    V delete(K key);
}


// НЕ ДЕЛАЙТЕ это всё в одном файле 🙏🙏🙏

public class HashMapImpl<V> implements HashMap<String, V> {
    private static final int TABLE_SIZE = 300007;
    private static final int A = 31;

    /**
     * Алгоритм хеширования строк.
     *
     * @param value ключ, по которому сохранится значение в хэш-таблицу
     * @return значение хэша
     */
    private long hashByString(String value) {
        long hash = 0;
        for (Character ch : value.toCharArray()) {
            hash = (hash * A + ch) % TABLE_SIZE;
        }
        return hash;
    }

    @Override
    public void put(String key, V value) {
	// TODO
    }

    @Override
    public V getValue(String key) {
	// TODO
        return null;
    }

    @Override
    public V delete(String key) {
	// TODO
        return null;
    }
} 
```

