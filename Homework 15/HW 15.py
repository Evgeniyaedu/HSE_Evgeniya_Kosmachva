import os
from datetime import datetime
import sqlite3

from telegram import Update, KeyboardButton, ReplyKeyboardMarkup
from telegram.ext import Application, CommandHandler, MessageHandler, filters, ContextTypes


TOKEN = "" # ключ отдельно
user_data = {}


async def start_bot(update: Update, context: ContextTypes.DEFAULT_TYPE):
    user = update.effective_user
    hello = f"Привет, {user.full_name}! Рад приветствовать тебя в нашем агентстве путешествий! Чтобы мы могли учесть все Ваши пожелания и подобрать идеальный тур, пройдите, пожалуйста, опрос)"
    await update.message.reply_text(hello, reply_markup=main_menu())


def main_menu():
    keyboard = [
        [KeyboardButton("Пройти опрос")],
    ]
    return ReplyKeyboardMarkup(keyboard, resize_keyboard=True)


async def handle_messages(update: Update, context: ContextTypes.DEFAULT_TYPE):
    user_choice = update.message.text
    user_id = update.effective_user.id
    if user_choice == "Пройти опрос":
        await destination(update)
    elif user_id in user_data:
        current_step = user_data[user_id].get("step")
        if current_step == "waiting_dest":
            await dest_save(update, context)
        elif current_step == "waiting_time":
            await time_save(update, context)
        elif current_step == "waiting_how_many_days":
            await how_many_days_save(update, context)
        elif current_step == "waiting_budget":
            await budget_save(update, context)
        elif current_step == "waiting_notions":
            await notions_save(update, context)
    else:
        await update.message.reply_text("Пожалуйста, используйте кнопки меню")


async def destination(update: Update):
    user = update.effective_user
    user_id = update.effective_user.id
    user_data[user_id] = {
        "step":"waiting_dest",
        "answer":[]
    }
    text_destination = f"{user.full_name}, куда Вы хотите поехать?"
    await update.message.reply_text(text_destination)


async def dest_save (update:Update, context:ContextTypes.DEFAULT_TYPE):
    user_id = update.effective_user.id
    answer = update.message.text
    list = []
    list.append(answer)
    user_data[user_id]["answer"].append (answer)
    user_data[user_id]["step"]="waiting_time"
    await time (update)


async def time(update: Update):
    user = update.effective_user
    text_time = f"{user.full_name}, когда Вы планируете поездку?"
    await update.message.reply_text(text_time)


async def time_save(update:Update, context:ContextTypes.DEFAULT_TYPE):
    user_id = update.effective_user.id
    answer = update.message.text
    user_data[user_id]["answer"].append(answer)
    user_data[user_id]["step"] = "waiting_how_many_days"
    await how_many_days(update)


async def how_many_days(update: Update):
    user = update.effective_user
    text_how_many_days = f"{user.full_name}, на сколько дней?"
    await update.message.reply_text(text_how_many_days)


async def how_many_days_save(update:Update, context:ContextTypes.DEFAULT_TYPE):
    user_id = update.effective_user.id
    answer = update.message.text
    user_data[user_id]["answer"].append(answer)
    user_data[user_id]["step"] = "waiting_budget"
    await budget (update)


async def budget(update: Update):
    user = update.effective_user
    text_budget = f"{user.full_name}, какой бюджет путешествия?"
    await update.message.reply_text(text_budget)


async def budget_save(update:Update, context:ContextTypes.DEFAULT_TYPE):
    user_id = update.effective_user.id
    answer = update.message.text
    user_data[user_id]["answer"].append(answer)
    user_data[user_id]["step"] = "waiting_notions"
    await notions (update)


async def notions(update: Update):
    user = update.effective_user
    text_notions = f"{user.full_name}, есть ли особые пожелания к поездке"
    await update.message.reply_text(text_notions)


async def notions_save(update:Update, context:ContextTypes.DEFAULT_TYPE):
    user_id = update.effective_user.id
    answer = update.message.text
    user_data[user_id]["answer"].append(answer)
    await save_to_database (update)

async def thanks(update:Update):
    text_thanks = "Спасибо! Мы свяжемся с Вами в течение 24 часов!"
    print (user_data)
    await update.message.reply_text(text_thanks, reply_markup=main_menu())


def init_database():
    create = sqlite3.connect("Database_travellata.db")
    cursor = create.cursor()
    cursor.execute("""
        CREATE TABLE IF NOT EXISTS Answers (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            user_id INTEGER,
            user_name TEXT,
            destination TEXT,
            time TEXT,
            how_many_days TEXT,
            budget TEXT,
            notions TEXT
        )
    """)

async def save_to_database(update:Update):
    user = str(update.effective_user.username)
    user_id = update.effective_user.id
    answer = user_data[user_id]["answer"]
    create = sqlite3.connect("Database_travellata.db")
    cursor = create.cursor()
    cursor.execute(""" 
        INSERT INTO Answers
        (user_id,user_name,destination,time,how_many_days,budget,notions)
        VALUES(?,?,?,?,?,?,?)
    """,(
        user_id, user, answer[0], answer[1],answer[2],answer[3],answer[4]
    ))
    create.commit()
    create.close()
    await thanks(update)


def main():
    init_database()
    application = Application.builder().token(TOKEN).build()

    application.add_handler(CommandHandler("start", start_bot))
    application.add_handler(MessageHandler(filters.TEXT & ~filters.COMMAND, handle_messages))

    application.run_polling()


if __name__ == "__main__":
    main()