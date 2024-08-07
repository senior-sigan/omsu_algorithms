---
layout: page
title: Задание 12. Калькулятор
---

![бобёр](/assets/bober.png)

# Калькулятор

Мы с вами будем делать КАЛЬКУЛЯТОР! В том числе парсер выражения.

## Обратная польская запись

На [вики](https://ru.wikipedia.org/wiki/Обратная_польская_запись) описано хорошо.

Ваша программа должна уметь вычислять выражения в обратной польской записи и поддерживать:

- бинарные операции + - * /
- целые числа, в том числе отрицательные.

Пример использования:

```cpp
int main() {
  int res = calc("4 1 + 5 *");
  assert(res == (4+1)*5);
}
```

## Программируемый польский калькулятор

Усложним программу: добавим поддержку создания своих операторов произвольной арности, добавим поддержку float типов.

Проектируйте калькулятор, как библиотеку, чтобы пользователь мог дописать свой оператор и встроить в наш калькулятор, не меняя код самой библиотеки.

Главные нововведения:

- парсинг float чисел
- создание операций произвольной арности, например, `sum` должна просуммировать вообще всё что в стеке лежит.

Нельзя использовать std::atoi-like функций. Сами встройте парсер числа.

```cpp
int main() {
  ModuleOp mod_op;
  Calculator calc;
  calc.register("%", &mod_op);
  SumOp sum_op;
  calc.register("sum", &sum_op);

  {
  auto s = "6 8 + 3 %";
  auto tokens = Tokenize(s);
  float res = calc.eval(tokens);
  assert(res == (6+8) % 3);
  }

  {
    auto tokens = Tokenize("1 2 3 4 5 6 sum");
    float res = calc.eval(tokens);
    assert(res == 1 + 2 + 3 + 4 + 5 + 6);
  }
}
```

## Нормальный калькулятор

Сделайте так, чтобы ваша библиотека поддерживала парсинг записей в инфиксной нотации: примение [алгоритм сортировочной станции](https://en.wikipedia.org/wiki/Shunting_yard_algorithm).

```cpp
int main() {
  ModuleOp mod_op;
  Calculator calc;
  calc.register("%", &mod_op);
  SumOp sum_op;
  calc.register("sum", &sum_op);

  string s = "(1 + 4) / 5 + 9 % 2";
  auto infix_tokens = Tokenize(s);

  auto polish_tokens = ShuntingYard(infix_tokens);

  float res = calc.eval(polish_tokens);
}
```

# Подсказки

Применяйте ООП.

Можете посмотреть мой [старый стрим на твитче](https://youtu.be/3aMpifryO1A?si=mSIt0RVEoyP0sH2A) про Польский калькулятор.
