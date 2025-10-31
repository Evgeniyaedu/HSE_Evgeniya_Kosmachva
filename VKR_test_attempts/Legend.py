import json

print("task")

contract_trade = {"1.1": "Покупатель образуется оплатить товар в течение 5 дней", "1.2": "Стоимость товара 5 руб.", "1.3":"Гарантия на товар 10 дней"}
with open("contract_trade_json.json", "w",encoding="utf-8") as file:
    json.dump(contract_trade,file,ensure_ascii=False,indent=2) # ensure_ascii=False - корректное написание кириллицей, indent = 2  для отступов

with open("contract_trade_json.json", "r", encoding="utf-8") as file:
    contract_trade_user=json.load(file)
print(contract_trade_user)


while True:
    print("Выберите пункт:\n1.Редактировать п.1.1.\n2.Редактировать п.1.2.\n3.Редактировать п.1.3.\n4.Просмотреть\n5.Закончить работу")
    while True:
        answer=input(">")
        if answer in ["1","2","3","4","5"]:
            break
        else:
            print("Такой пункт отсутствует")
    if answer == "5":
        break
    else:
        if answer == "1":
            contract_trade_user["1.1"]= input("Предложите Вашу редакцию: ")
        elif answer == "2":
            contract_trade_user["1.2"]= input("Предложите Вашу редакцию: ")
        elif answer == "3":
            contract_trade_user["1.3"]= input("Предложите Вашу редакцию: ")
        elif answer == "4":
            print ("Договор")
            for key,value in contract_trade_user.items():
                print(f"{key} : {value}")

user="Masha"

new_name_of_file = user + "_" + "contract_trade_json.json"

with open(new_name_of_file, "w", encoding="utf-8") as file:
    json.dump(contract_trade_user, file, ensure_ascii=False, indent=2)



