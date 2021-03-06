{--34-1
Для типа Expr написать функцию simplify. Эта функция должна упрощать выражение, 
используя только два очень простых правила:

выражение * 1 = выражение
и
1 * выражение = выражение

Пример вызова:

simplify (Add (Mult X (Num 1)) X)

Должно получиться:
Add X X

Замечание:
- В этой задаче используется Expr с одной переменной, с прошлого занятия 
- Чтобы было немного сложнее, в этой задаче в тестах вы не увидете выражения, не котором этот тест проверяет. 
Подумайте сами, какие при упрощении могут быть более сложные случаи?
- Не забудьте написать deriving Show (а может вам потребуется и deriving Eq)--}

data Expr = Num Integer | X | Add Expr Expr | Mult Expr Expr deriving Show 

simplify (Num i) = Num i
simplify X = X
simplify (Add a b) = Add (simplify a) (simplify b)

simplify (Mult (Num 1) a) = simplify a
simplify (Mult a (Num 1)) = simplify a
simplify (Mult a b) = newsimpify (simplify a) (simplify b)

newsimpify (Num 1) b = b
newsimpify a (Num 1) = a
newsimpify a b = Mult a b

eval (Num i) _ = i
eval X n = n
eval (Add x y) n = eval x n + eval y n
eval (Mult x y) n = eval x n * eval y n

test = Mult (Mult (Num 1) (Num 1)) X
test1 = Mult ( Mult (Num 1) (Mult (Num 1) (Num 1))) (Num 1)



----------------------------------------------------------------------------------------
{--34.2
Реализовать функцию dec, которая вычитает 1 из числа Черча.

Пример вызова: 
dec (\ f x -> f (f (f x))) 
должен вернуть \ f x -> f (f x). 

Для проверки имеет смысл вызвать так:
toInt (dec (\ f x -> f (f (f x)))) 
и ответ д.б. равен 2.

Замечания:
- Для того, чтобы тесты прошли, опишите, пожалуйста, в программе функцияю toInt
- Имеется в виду, что в этой задаче нельзя использовать встроенные функции и вообще 
нельзя использовать настоящие целые числа (потому что глобальная задача - показать, 
что встроенные целые числа теоретически не очень нужны, их можно моделировать). 
Например, нельзя перевести число Черча в обычное, вычесть 1 и перевести обратно.
- Но можно, если хотите, использовать пары! Это подсказка, используя пары это можно 
написать относительно просто. А в следующий раз мы обсудим, как с этим справился Клини, 
у которого пар не было, и это будет еще одна доп. задача.
- Вот тут есть подсказка: http://msimuni.wikidot.com/fp-cleene-hint
Как обычно, если вы ее прочтете, и она вам поможет, напишите в комментарии пожалуйста.
- Если подсказка не поможет, но решить задачу хочется, напишите, попробую еще подсказать.--}

toInt g = g (+1) 0

dec g = \f x -> fst $ fst $ g apply' ((x, x), f)
                    where apply' ((_, a), f)= ((a, f a), f)
            



