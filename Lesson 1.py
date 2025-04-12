name = 'Evgeniya'
surname = 'Education'
print(name + ' ' +surname)
company_list = ["Like", "Smile"]


# first task with different types
print (company_list)
int_number_1 = 52
print(int_number_1)
float_number_2 = 3.14
print(float_number_2)
str_first = 'Hello,world!'
print (str_first)
List_example_1=['1,8,81,102,17']
print(List_example_1)
dict_example_1={"Name": "Steve","Surname": "Jobes", 'age': '21'}


# Task with inputs
phrase = input('Write your name: ')
print(phrase)
phrase_2 = input ("Write your age:")
print (phrase_2)
# task with id
object_id=id(float_number_2)
print (object_id)
phrase_3=input ('Wtite time in seconds:')
print (phrase_3)



# task with time
if phrase_3.isdigit():
    total_seconds=int(phrase_3)
    hours=total_seconds//3600
    remaining_seconds = total_seconds % 3600
    minutes = remaining_seconds // 60
    seconds = remaining_seconds % 60
    hours_var=hours
    minutes_var=minutes
    seconds_var=seconds
    print("\nРезультат перевода секунд:")
    print("Часы:", hours_var)
    print("Минуты:", minutes_var)
    print("Секунды:", seconds_var)
else:
    print("Ошибка: введите целое число секунд.")



    # task with numbers
n_input = input('Write number from 1 to 9:')
if n_input.isdigit() and 1 <= int(n_input) <= 9:
    n = int(n_input)
    nn = int(str(n) * 2)
    nnn = int(str(n) * 3)
total = n + nn + nnn
print(f"\nРезультат вычисления {n} + {nn} + {nnn} = {total}")




