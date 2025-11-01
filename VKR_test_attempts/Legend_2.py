
tests = {

    "п.1.1":
        {
            "текст": (
                "Поставщик доставляет товар своими силами и за свой счет"
            ),

            "варианты": [
                "бла-бла-бла ",
                "бу-бу-бу ",
                "би-би-би "
            ],

            "правильный_ответ": [1]
        },

    # следующий вопрос
    "п.1.2":

        {
            "текст": (
                "Срок гарантийного обслуживания 36 месяцев"
            ),
            "варианты": [
                "бла-бла-бла ",
                "бу-бу-бу ",
                "би-би-би "
            ],

            "правильный_ответ": [3]
        },
    "п.1.3":

        {
            "текст": (
                "Товар поставляется по предоплате"
            ),
            "варианты": [
                "бла-бла-бла ",
                "бу-бу-бу ",
                "би-би-би "
            ],

            "правильный_ответ": [2]}
}


def display_question(test):

    print(f"Текст: {test['текст']}\n")



    for i, option in enumerate(test['варианты'], 1):
        print(f"{i}. {option}")


# это на всякий случай, если будет больше чем один правильный ответ
def check_answers(user_answers, correct_answers):

    user_answers_set = set(map(int, user_answers.split(',')))

    correct_answers_set = set(correct_answers)

    return user_answers_set == correct_answers_set



def main():

    right_answers = 0

    all_questions = 0


    for name, test in tests.items():

        print(f"\n{name}")

        display_question(test)

        user_answers = input("\nВведите ответ: ")

        if check_answers(user_answers, test['правильный_ответ']):
            print("Верно!")

            right_answers += 1
        else:
            print("Неверно!")

        all_questions += 1


    print(f'Вы ответили правильно на {right_answers} вопросов из {all_questions}.'
          f'\nХотите попробовать ещё раз? (Да/Нет)')


    one_more_test = input('')

    if one_more_test == 'Да':
        main()


main()
