{--18.1
Описать функцию bigCos c параметром x, которая возвращает первый элемент в последовательности 
cos 1, cos 2, cos 3, cos 4, ... , который больше или равен x. 

Дополнительное условие: нельзя определять свои функции (кроме bigCos, конечно). 
Можно использовать любые стандартные функции и лямбда выражения. 

Пример вызова: 
bigCos 0.99 результат должен быть равен примерно 0.9912028 

Замечания:
- очевидная подсказка: тут, конечно, удобно использовать бесконечные списки. Но можно и без них, наверное.--}

bigCos x = (filter (>=x) [cos n | n <- [1..]])!!0



{--18.2
Пусть в списке я записал последовательность чисел - сколько денег я тратил каждый день в этом году. 
Запись я начал, конечно же, с понедельника.
Кроме этого я дал себе слово - по будним дням тратить не больше 300 р в день, а по выходным - не больше 1000 р. в день.
Опишите функцию checkMyRules у которой параметр - такой список расходов, и которая проверяет, 
выполнил ли я свои собственные правила. 

Примеры вызова: 
checkMyRules [100,200,150,250,100,200,800,100,300,200] 
Ответ должен быть равен True. 
checkMyRules [100,200,150,250,100,200,800,100,600,200] 
Ответ должен быть равен False, потому что во второй вторник я потратил больше 300 р. 

Замечание:
- В этой задаче можно (но не обязательно) использовать зацикленный список--}

checkMyRules xs = null (filter (<0) (map (\pair -> fst pair - snd pair) pairs))
                         where pairs = zip (cycle [300, 300, 300, 300, 300, 1000, 1000]) xs



{--18.3
Опишите brackets, как бесконечный список из строк, вот такой: ["[]","[[]]","[[[]]]","[[[[]]]]"...]

Дополнительное условие: В этой задаче обязательно надо использовать прием "завязывание в узел"

Пример вызова:
take 4 brackets
Результат должен быть равен ["[]","[[]]","[[[]]]","[[[[]]]]"]

Напоминание: строки в Haskell - это списки символов. То есть, к ним можно применять операции 
:, ++ и другие функции для списков.--}

plusOneBracket (x:xs) = ("[" ++ x ++"]") : plusOneBracket xs
brackets = "[]" : plusOneBracket brackets



{--18.4
*Еще одна задача про тридевятое царство*

1. Описать оператор <=< который работает так же, как оператор . (композиция функций), но только для функций, которые возвращают пару (результат, цена).
Например, если у нас есть функции
sin39 x = (sin x, 2)
cos39 x = (cos x, 3)
и потом мы напишем
f = cos39 <=< sin39
то f должна для x возвращать пару (cos(sin x),5)

2. Описать функцию calculate из задачи 15-4 с помощью foldr и оператора <=<

Подсказка: определение, скорее всего, будет выглядеть как-то так:
calculate fs = foldr (<=<) ...какая то функция.. fs

Замечание: В определении calсulate приведенном выше, в принципе можно не писать слева и справа fs (потому что работает карринг). Но в системе тестирования есть, видимо, некоторая проблема, из за которой без fs тесты не пройдут ( Те пишите тут fs.

Примеры вызова:
let { f x = (2*x, 1); g = f <=< а } in g 10
Результат должен быть равен (40,2)
let f x = (2*x,1) in calculate [f,f,f] 1
Результат должен быть равен (8,3)--}


infixr 9 <=<
(<=<) b a = \x -> (let 
                    a' = a x
                    b' = b (fst a')
                   in (fst b', snd a' + snd b')) 

f0 x = (x, 0)
calculate fs x = foldr (<=<) f0 fs $ x

--calculate funcList x = foldr (\f pair -> (fst (f (fst pair)), snd pair + snd (f (fst pair)))) (x, 0) funcList


sin39 x = (sin x, 2)
cos39 x = (cos x, 3)
fu x = (x*x+5, 10)

--f = cos39 <=< sin39 

test = calculate [sin39,cos39,fu] 1





{--18.5 
Описать функцию superMap, которая похожа на map, но только позволяет заменять элемент в списке не на один, 
а на несколько.
Пример вызова:
superMap (\x -> [sin x, cos x]) [1,2,3]
Должен получиться список [sin 1, cos 1, sin 2, cos 2, sin 3, cos 3].

Замечание: На самом деле, в Haskell есть сразу две стандартные функции, которые делают точно то же, что superMap. 
Но даже если вы знаете, как они называются, в этом задании вы, пожалуйста, их не используйте. 
Все остальные стандартные функции использовать можно.--}

superMap fs xs = map (\x -> map (\f -> f $ x) fs) xs