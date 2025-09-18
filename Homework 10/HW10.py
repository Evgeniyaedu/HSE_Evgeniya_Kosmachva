#task 1
import random
from array import * # импортирует все функции из модуля array
a=random.randint(3,5)
array=array('i') # i-целые числа, f- float,d - double (вещественное число с двойной точностью), u-строки, символы
for i in range (10,250000000,a):
    array.append(i)

while True:
    try:
        number=int (input ("Введите число:"))
        if number in array:
            break
        else:
            print("Такого числа нет в массиве")
    except ValueError:
        print("Введите другое число")

find_index=-1
start_array = 0
finish_array=len(array)-1
while find_index==-1:
    central_int = (start_array+finish_array) // 2
    if number>array[central_int]:
        start_array=central_int
    elif number<array [central_int]:
        finish_array=central_int
    else:
        find_index=central_int
print(find_index)


#task 2

numbers=[random.randint(0,2000) for i in range (10)]
print (numbers)

# task 3
def line_search (a,results):
    find_index=-1
    i=0
    while find_index==-1:
        if a==results[i]:
           return i
        else:
            i+=1
list_of_results=[i for i in range(0,100)]
print (line_search (int(input( "Введите число:")),list_of_results))

# task 4
array_4=[i for i in range(0,100)]
while True:
    try:
        number=int (input ("Введите число:"))
        if number in array_4:
            break
        else:
            print("Такого числа нет в массиве")
    except ValueError:
        print("Введите другое число")
def binar_search(number,array_4):
    find_index=-1
    start_array = 0
    finish_array=len(array_4)-1
    while find_index==-1:
        central_int = (start_array+finish_array) // 2
        if number>array_4[central_int]:
            start_array=central_int
        elif number<array_4 [central_int]:
            finish_array=central_int
        else:
            find_index=central_int
    print(find_index)
binar_search (number, array_4)



# task 5
import time
a=random.randint(3,5)
array=array('i') # i-целые числа, f- float,d - double (вещественное число с двойной точностью), u-строки, символы
for i in range (10,5000):
    array.append(i)
while True:
    number=random.randint(10,5000)
    if number in array:
        break


def line_search (a,results):
    find_index=-1
    i=0
    while find_index==-1:
        if a==results[i]:
           print(i)
           break
        else:
            i+=1

def binar_search(number,array_4):
    find_index=-1
    start_array = 0
    finish_array=len(array_4)-1
    while find_index==-1:
        central_int = (start_array+finish_array) // 2
        if number>array_4[central_int]:
            start_array=central_int
        elif number<array_4 [central_int]:
            finish_array=central_int
        else:
            find_index=central_int
    print(find_index)

start_time=time.time ()
line_search(number,array)
end_time=time.time()
print (f"Время выполнения поиска: {end_time-start_time}")

start_time=time.time ()
binar_search (number,array)
end_time=time.time()
print (f"Время выполнения поиска: {end_time-start_time}")
