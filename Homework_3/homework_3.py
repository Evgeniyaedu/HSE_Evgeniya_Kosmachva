# task 1 part 1

def factorial(n):
    if n < 0:
        raise ValueError("Факториал может быть только натуральным числом")
    if n == 0 or n == 1:
        return 1
    result = 1
    for i in range(2, n + 1):
        result *= i
    return result
print(factorial(6))
print(factorial(3))

# task 1 part 2

def find_max_of_three(numbers):

    if len(numbers) != 3:
        raise ValueError("Функция принимает ровно 3 числа")

    if not all(isinstance(x, (int, float)) for x in numbers):
        raise TypeError("Все элементы должны быть числами")

    a, b, c = numbers
    return max(a, b, c)

print(find_max_of_three((31, 17, 85)))
print(find_max_of_three((102,17,89)))

# task 1 part 3

def right_triangle_area(leg_a, leg_b):

    if leg_a <= 0 or leg_b <= 0:
        raise ValueError("Длины катетов должны быть положительными числами")
    return (leg_a * leg_b) / 2

print(right_triangle_area(6, 8))

# task 2 part 1
