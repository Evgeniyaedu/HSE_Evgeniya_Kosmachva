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

import time
from lesson_2_dzdata import courts

for i in courts:
    print(i['court_name'])

    import time
    from traceback import format_exception
    from lesson_2_dzdata import respondents, courts


    def gen_court_header(court: dict) -> str:
        header = f"В {court['court_name']}\n" \
                 f"Адрес: {court['court_address']}\n"
        return header


    def gen_respondent_header(respondent: dict) -> str:
        header = f"Ответчик: {respondent['short_name']}\n" \
                 f"ИНН {respondent['inn']} ОГРН {respondent['ogrn']}\n" \
                 f"Адрес: {respondent['address']}\n" \
                 f"---------------"
        return header

    def gen_number_header (respondent: dict) -> str:
        header = f"Дело №: {respondent['case_number']}\n"
        return header


    def main():
        print('start')
        court_mapping = {i['court_code']: i for i in courts}
        for i in respondents:
            try:
                code = i['case_number'][:3]
                court = court_mapping[code]
                court_header = gen_court_header(court)
                print(court_header)
                respondent_header = gen_respondent_header(i)
                print(respondent_header)
                case_number_header = gen_number_header(i)
                print(case_number_header)

            except Exception as exc:
                format_exception(exc)
                continue


    if __name__ == "__main__":
        main()
        print('stop')