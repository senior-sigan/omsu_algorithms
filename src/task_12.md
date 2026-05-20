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

```java
public static void main(String[] args) {
    int expected = (4 + 1) * 5;
    int actual = calc("4 1 + 5 *");
    if (expected == actual) {
        System.out.println("Вычисления правильны, ответ: " + actual);
    } else {
        System.out.println("Ожидалось: " + expected + "; но получили " + actual);
    }
}
```

## Программируемый польский калькулятор

Усложним программу: добавим поддержку создания своих операторов произвольной арности, добавим поддержку float типов.

Проектируйте калькулятор, как библиотеку, чтобы пользователь мог дописать свой оператор и встроить в наш калькулятор, не меняя код самой библиотеки.

Главные нововведения:

- Парсинг float чисел
- Добавление арности для операторов. Если по-простому, арность - это количество параметров у оператора. Например, у оператора `+` арность 2, у `*` тоже 2. Важный момент в том, что отрицательное число из прошлого пункта - это не число вида `-31`, а число `31` к которому применили операцию унарный минус `-`. Различать по контексту унарный минус с арностью 1 от минуса с арностью 2 может быть проблематично, поэтому в качестве оператора унарного минуса можно использовать `m`
- Создание операций произвольной арности, например, `sum` должна просуммировать вообще всё что в стеке лежит. Но будьте внимательны, помимо оператора `sum` могут быть и другие операторы, например `1 2 3 sum 4 *`

Нельзя использовать `Double.parseDouble` и все подобные методы. Сами встройте парсер числа.

Пример того, как должно всё это использоваться.

```java
public static void main(String[] args) {
    Calculator calc = new Calculator();
    calc.register("+", new AdditionOperation());
    calc.register("%", new ModOperation());
    calc.register("sum", new SumOperation());
    
    Tokenizer tokenizer = new PostfixTokenizer();
    
    String equasion1 = "6 8 + 3 %";
    List<String> tokens1 = tokenizer.tokenize(equasion1);
    double result1 = calc.evaluate(tokens1);
    System.out.println("Тест 1 результат: " + result1);
    
    String equasion2 = "1 2 3 4 5 6 sum";
    List<String> tokens2 = tokenizer.tokenize(equasion2);
    double result2 = calc.evaluate(tokens2);
    System.out.println("Тест 2 результат: " + result2);
}
```

<details>
<summary>Примерный вариант интерфейсов калькулятора</summary>

Общий интерфейс для каждой операции, к которой будет привязан оператор. Все +, -, /, * должны реализовывать его
Operator.java
```java
public interface Operator {
    /**
     * Возвращает количество аргументов, необходимых оператору.
     * Если возвращает -1, значит оператор поглощает весь стек (вариативная арность).
     * 
     * @return значение арности
     */
    int getArity();

    /**
     * Выполнить операцию над стеком калькулятора и записать полученное значение в него.
     * 
     * @param stack текущее состояние стека
     */
    void execute(Stack<Double> stack);
}
```

Это интерфейс токенизатора, который будет разбивать входную строку на список отдельных токенов. 
Tokenizer.java
```java
public interface Tokenizer {
    
    /**
     * Преобразование входной строки в список токенов.
     *
     * @param expression строка математического выражения
     * @return список строковых токенов
     */
    List<String> tokenize(String expression);
}
```
Дальше у него можно сделать класс `PostfixTokenizer`, который разобъёт входную строку на эти токены.

У класса `Calculator` методы представлены в примере, на данный момент их хватит

</details>

## Нормальный калькулятор

Сделайте так, чтобы ваша библиотека поддерживала парсинг записей в инфиксной нотации: примение [алгоритм сортировочной станции](https://en.wikipedia.org/wiki/Shunting_yard_algorithm).

Важный момент касательно оператора `sum` из прошлого пункта. Написание `1 2 3 4 sum` - это его обратная польская запись. В инфиксной записи он должен выглядеть так `sum(1, 2, 3, 4)` или хотя бы так `sum(1 2 3 4)`

```java
public static void main(String[] args) {
    CalculatorConfig infixConfig = new CalculatorConfig(
        new InfixTokenizer(), 
        new ShuntingYardParser()
    );
    Calculator calc = new Calculator(infixConfig);
    
    calc.register("+", new AdditionOperation());
    calc.register("/", new DivisionOperation());
    calc.register("%", new ModOperation());
    calc.register("sum", new SumOperation());
    
    String equasion = "sum(1, 2, 3, 4) / 5 + 9 % 2";
    List<String> tokens = calc.tokenize(equasion);
    
    List<String> polishTokens = calc.toPolishNotation(tokens);
    
    double result = calc.evaluate(polishTokens);
    System.out.println("Результат: " + result);
}
```

<details>
<summary>На что можно опереться здесь</summary>

В интерфейс `Operator.java` добавим два новых метода.
```java
public interface Operator {
    /**
     * Возвращает количество аргументов, необходимых оператору.
     * Если возвращает -1, значит оператор поглощает весь стек (вариативная арность).
     * 
     * @return значение арности
     */
    int getArity();
    
    /**
     * Получить значение приоритета, заданное для определённого оператора.
     * 
     * @return значение приоритета
     */
    int getPrecedence();
    
    /**
     * @return `true` если оператор левоассоциативен
     */
    boolean isLeftAssociative();

    /**
     * Выполнить операцию над стеком калькулятора и записать полученное значение в него.
     * 
     * @param stack текущее состояние стека
     */
    void execute(Stack<Double> stack);
}
```

Добавьте новую реализацию интерфейса `Tokenizer.java` для инфиксной записи выражения - `InfixTokenizer`.

Класс `ShuntingYardParser` будет содержать внутри себя алгоритм сортировочной станции. 
Под него можно выделить интерфейс типа такого
```java
public interface ExpressionParser {
    /**
     * Переводим один формат токенов в другой.
     * 
     * @param tokens изначальные токены
     * @param registry мапа с зарегистрированными в калькуляторе токенами
     * @return список преобразованныех токенов
     */
    List<String> parse(List<String> tokens, Map<String, Operator> registry);
}
```

Класс `CalculatorConfig` можно добавить для того, чтобы инкапсулировать в себе возможные настройки для нашего `Calculator`.
Если он будет в себе содержать поля с типами интерфейсов, то такой калькулятор можно будет просто перенастроить снова
на работу с постфиксной записью. Достаточно будет сделать новый объект класса-конфига
```java
    CalculatorConfig postfixConfig = new CalculatorConfig(
        new PostfixTokenizer(), 
        new IdentityParser()
    );
```

</details>

# Дополнение

Все предыдущие изыскания оперались на том, что основной метод интерфейса-токенизатора такой: `List<String> tokenize(String expression);`. Важный момент в том, что он возвращает список строк, которые являются токенами. Но...почему строк?

В идеальном мире интерфейс-токенизатора должен выглядеть так
```java
public interface Tokenizer {
    
    /**
     * Преобразование входной строки в список токенов.
     *
     * @param expression строка математического выражения
     * @return список токенов
     */
    List<Token> tokenize(String expression);
}
```

Да, лучше будет сделать отдельный класс `Token`, который будет инкапсулировать в себе всю информацию о конкретном токене.
Чем это поможет? Если вы читаете это после реализации класса `ShuntingYardParser`, то вы скорее всего столкнулись с большим количеством проверок вида `token.equals(")")` и постоянных проверок строки на то, является ли она числом. 

Так при токенизации сразу получится список готовых токенов `Token`, каждый из которых будет хранить и оригинальное строковое значние (типа "(", "+" или "67"), и готовое числовое значение (если это число), и тип токена.

Под тип токена лучше сделать отдельный энам `TokenType` типа такого
```java
public enum TokenType {
    NUMBER,
    OPERATOR,
    OPEN_PAREN,
    CLOSE_PAREN,
    UNKNOWN
}
```

Это очень сильно сократит вам код и `ShuntingYardParser`, и самого калькулятора.

И если вы будете выбрасывать какие-то исключения во время работы калькулятора (а вы должны это делать в определённых кейсах), можно кидать не стандартные исключения, а свои кастомные типа такого
```java
class CalculatorException extends RuntimeException {
    CalculatorException(String message) {
        super(message);
    }
}
```

# Подсказки

Применяйте ООП.

Можете посмотреть мой [старый стрим на твитче](https://youtu.be/3aMpifryO1A?si=mSIt0RVEoyP0sH2A) про Польский калькулятор.

