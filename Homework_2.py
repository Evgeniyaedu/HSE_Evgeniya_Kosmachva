participants = []

for i in range (3):
    print (f"\nWrite name of participant {i+1}:")
    name = input ("Name:")
    status = input ("Status Истец/Ответчик/Третье лицо:")
    inn = input ("inn:")

    participant = {
        "name": name,
        "status": status,
        "inn": inn
    }

    participants.append (participant)
