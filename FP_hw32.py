'''a. Написать на C# функцию Find, которая в данном массиве целых чисел ищет элемент, 
удовлетворяющий данному логическому условию. При этом функция должна использовать failure continuation, 
чтобы обрабатывать случай, когда ничего не найден.

б. Привести пример, как с помощью Find можно решить пример с занятий: 
"Найти в массиве первое число, большее 1000, а если его нет, то первое число, большее 500, 
а если и его нет, то первое число большее 100 (а если и его нет, вернуть 0)".

Технические замечания про failure continuation на C# см. тут: 
http://msimuni.wikidot.com/fp-failure-continuation 

Замечания:
- Если хотите, можете решить задачу для List или вообще для IEnumerable - как вам удобнее.
- Эта задача, на самом деле, очень простая, надо только понять, о чем вообще речь.'''


def Find(func, arr, error):
    if any(func(a) for a in arr):
        return list(filter(func, arr))[0]
    else:
        return error()

lst = [1, 5, 100, 51, 10]

ex_b = Find((lambda x: x > 1000), lst, lambda: ( 
            Find((lambda x: x > 500), lst, lambda: (
                Find((lambda x: x > 100), lst, lambda: 0)))))

print(ex_b)



#print(Find( (lambda x: x > 1000), [1, 10, 100, 101], (lambda: "Error!")))