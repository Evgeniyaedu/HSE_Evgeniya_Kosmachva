def validate_inn(inn_str: str) -> bool:
    if not isinstance(inn_str, str):
        return False

    # Чтобы не было разделителей
    inn = ''.join(filter(str.isdigit, inn_str))

    # Проверка длины
    if len(inn) == 10:
        return _validate_inn10(inn)
    elif len(inn) == 12:
        return _validate_inn12(inn)
    else:
        return False


def _validate_inn10(inn: str) -> bool:

    if len(inn) != 10 or not inn.isdigit():
        return False

    # Коэффициенты для проверки 10-значного ИНН (из задачи)
    coefficients = (2, 4, 10, 3, 5, 9, 4, 6, 8)

    # Контрольная сумма
    control_sum = sum(int(inn[i]) * coefficients[i] for i in range(9))

    # контрольное число
    control_number = control_sum % 11
    if control_number > 9:
        control_number %= 10

    # Сравненеие с 10-й цифрой ИНН
    return control_number == int(inn[9])


def _validate_inn12(inn: str) -> bool:

    if len(inn) != 12 or not inn.isdigit():
        return False

    # Проверка (11-я цифра)
    coefficients_11 = (7, 2, 4, 10, 3, 5, 9, 4, 6, 8)
    control_sum_11 = sum(int(inn[i]) * coefficients_11[i] for i in range(10))

    control_number_11 = control_sum_11 % 11
    if control_number_11 > 9:
        control_number_11 %= 10

    if control_number_11 != int(inn[10]):
        return False

    # Проверка (12-я цифра)
    coefficients_12 = (3, 7, 2, 4, 10, 3, 5, 9, 4, 6, 8)
    control_sum_12 = sum(int(inn[i]) * coefficients_12[i] for i in range(11))

    control_number_12 = control_sum_12 % 11
    if control_number_12 > 9:
        control_number_12 %= 10

    return control_number_12 == int(inn[11])


new_inn = "7830002293"
print("valid" if validate_inn(new_inn) else "not valid")
