from telegram import Update, KeyboardButton, ReplyKeyboardMarkup
from telegram.ext import Application, CommandHandler, MessageHandler, filters, ContextTypes

TOKEN = "" # ключ отдельно


def main_menu():
    keyboard = [
        [KeyboardButton("Подготовиться к экзамену на адвоката")],
        [KeyboardButton("Подготовиться к экзамену на судью")],
        [KeyboardButton("Подготовиться к экзамену на нотариуса")],
        [KeyboardButton("Записаться на консультацию")],
    ]
    return ReplyKeyboardMarkup(keyboard, resize_keyboard=True)


def options_adv():
    keyboard = [
        [KeyboardButton("Пройти обучение")],
        [KeyboardButton("Пройти пробный тест")],
        [KeyboardButton("Назад в меню")]
    ]
    return ReplyKeyboardMarkup(keyboard, resize_keyboard=True)


def options_judge():
    keyboard = [
        [KeyboardButton("Пройти обучение")],
        [KeyboardButton("Пройти пробный тест")],
        [KeyboardButton("Назад в меню")]
    ]
    return ReplyKeyboardMarkup(keyboard, resize_keyboard=True)


def options_not():
    keyboard = [
        [KeyboardButton("Пройти обучение")],
        [KeyboardButton("Пройти пробный тест")],
        [KeyboardButton("Назад в меню")]
    ]
    return ReplyKeyboardMarkup(keyboard, resize_keyboard=True)


async def start_bot(update: Update, context: ContextTypes.DEFAULT_TYPE):
    user = update.effective_user
    hello = f"Привет, {user.full_name}! Рад тебя видеть! Давай подготовимся к экзамену вместе:)"
    await update.message.reply_text(hello, reply_markup=main_menu())


async def handle_messages(update: Update, context: ContextTypes.DEFAULT_TYPE):
    user_choice = update.message.text

    if user_choice == "Подготовиться к экзамену на адвоката":
        await message_adv(update)
    elif user_choice == "Подготовиться к экзамену на судью":
        await message_judge(update)
    elif user_choice == "Подготовиться к экзамену на нотариуса":
        await message_not(update)
    elif user_choice == "Записаться на консультацию":
        await message_cons(update)
    elif user_choice == "Назад в меню":
        await start_bot(update, context)
    else:
        await update.message.reply_text("Пожалуйста, используйте кнопки меню")


async def message_adv(update: Update):
    user = update.effective_user
    text_adv = f"{user.full_name}, с чего начнем подготовку к экзамену на адвоката?"
    await update.message.reply_text(text_adv, reply_markup=options_adv())


async def message_judge(update: Update):
    user = update.effective_user
    text_judge = f"{user.full_name}, с чего начнем подготовку к экзамену на судью?"
    await update.message.reply_text(text_judge, reply_markup=options_judge())


async def message_not(update: Update):
    user = update.effective_user
    text_not = f"{user.full_name}, с чего начнем подготовку к экзамену на нотариуса?"
    await update.message.reply_text(text_not, reply_markup=options_not())


async def message_cons(update: Update):
    user = update.effective_user
    text_cons = f"{user.full_name}, оставьте Ваш телефон и мы Вам обязательно перезвоним в течение 24 часов"
    await update.message.reply_text(text_cons)


def main():
    application = Application.builder().token(TOKEN).build()

    application.add_handler(CommandHandler("start", start_bot))
    application.add_handler(MessageHandler(filters.TEXT & ~filters.COMMAND, handle_messages))

    application.run_polling()


if __name__ == "__main__":
    main()