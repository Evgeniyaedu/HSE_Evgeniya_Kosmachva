with open ('traders.txt', 'r', encoding='utf-8') as f:
    inns = [line.strip() for line in f if line.strip().isdigit() and len(line.strip()) in (10, 12)]
    print("Список ИНН:", inns)

    # task 1 b

    import json

    def find_traders_by_inn(inn_list, json_file_path):

        try:
            with open(json_file_path, 'r', encoding='utf-8') as file:
                traders_data = json.load(file)
        except FileNotFoundError:
            print(f"Ошибка: Файл {json_file_path} не найден")
            return []
        except json.JSONDecodeError:
            print("Ошибка: Неверный формат JSON файла")
            return []

        inn_set = set(inn_list)

        found_traders = []
        for trader in traders_data:
            if trader.get('inn') in inn_set:
                found_traders.append(trader)

        return found_traders

    if __name__ == "__main__":

        inns_to_find = ['7702758341', '7802654025', '5027217264', '6324042940', '5834031870', '1657061756', '3665044042', '6453102410']

        json_file = "/Users/evgeniakosmaceva/PyCharmMiscProject/Homework_5/traders.json"

        results = find_traders_by_inn(inns_to_find, json_file)

        if results:
            print(f"Найдено {len(results)} организаций:")
            for trader in results:
                print("\nПолное название:", trader.get('full_name'))
                print("Короткое название:", trader.get('short_name'))
                print("ИНН:", trader.get('inn'))
                print("ОГРН:", trader.get('ogrn'))
                print("Адрес:", trader.get('address'))
                print("Дата последнего изменения:", trader.get('last_modified'))
        else:
            print("Организации с указанными ИНН не найдены.")

            # task 1 c

import json
import csv
import os


def json_to_csv(json_file_path, csv_file_path):


    try:
        with open(json_file_path, 'r', encoding='utf-8') as json_file:
            traders_data = json.load(json_file)

        csv_data = []
        for trader in traders_data:
            csv_data.append({
                'ИНН': trader.get('inn', ''),
                'ОГРН': trader.get('ogrn', ''),
                'Адрес': trader.get('address', '')
            })

        with open(csv_file_path, 'w', encoding='utf-8', newline='') as csv_file:
            fieldnames = ['ИНН', 'ОГРН', 'Адрес']
            writer = csv.DictWriter(csv_file, fieldnames=fieldnames)

            writer.writeheader()
            writer.writerows(csv_data)

        print(f"Данные успешно сохранены в файл {csv_file_path}")

        if not os.path.exists(csv_file_path):
            raise Exception(f"Не удалось создать файл {csv_file_path}")

    except FileNotFoundError as e:
        print(f"Ошибка: {str(e)}")
    except json.JSONDecodeError:
        print("Ошибка: Неверный формат JSON файла")
    except PermissionError:
        print(f"Ошибка: Нет прав для записи в файл {csv_file_path}")
    except Exception as e:
        print(f"Произошла ошибка: {str(e)}")

if __name__ == "__main__":
    input_json = "/Users/evgeniakosmaceva/PyCharmMiscProject/Homework_5/traders.json"
    output_csv = "traders.csv"

    json_to_csv(input_json, output_csv)

    #Task 2

    import re
    import json
    import os
    from typing import Dict, Set, List


    def find_emails(text: str) -> List[str]:
        email_pattern = r'\b[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Z|a-z]{2,}\b'
        return re.findall(email_pattern, text, re.IGNORECASE)


    def load_dataset(file_path: str) -> List[Dict]:
        if not os.path.exists(file_path):
            raise FileNotFoundError(f"Файл {file_path} не найден")

        with open("/Users/evgeniakosmaceva/PyCharmMiscProject/Homework_5/1000_efrsb_messages.json", 'r', encoding='utf-8') as file:
            return json.load(file)


    def collect_emails(dataset: List[Dict]) -> Dict[str, Set[str]]:
        emails_dict: Dict[str, Set[str]] = {}

        for entry in dataset:
            inn = entry.get('publisher_inn')
            text = entry.get('msg_text', '')

            if not inn or not text:
                continue

            found_emails = find_emails(text)

            if found_emails:
                if inn not in emails_dict:
                    emails_dict[inn] = set()
                emails_dict[inn].update(email.lower() for email in found_emails)

        return emails_dict


    def save_emails(emails_dict: Dict[str, Set[str]], output_file: str):
        result = {inn: sorted(emails) for inn, emails in emails_dict.items()}

        with open(output_file, 'w', encoding='utf-8') as f:
            json.dump(result, f, ensure_ascii=False, indent=2)
        print(f"Результаты сохранены в {os.path.abspath(output_file)}")


    def main():
        try:

            input_file = "/Users/evgeniakosmaceva/PyCharmMiscProject/Homework_5/1000_efrsb_messages.json"
            output_file = "emails.json"  # Файл будет создан автоматически

            print("Загрузка данных...")
            dataset = load_dataset(input_file)
            print(f"Загружено сообщений: {len(dataset)}")

            print("Поиск email-адресов...")
            emails = collect_emails(dataset)

            if not emails:
                print("Email-адреса не найдены")
                return

            print(f"Найдено:")
            print(f"- Уникальных ИНН: {len(emails)}")
            print(f"- Всего email-адресов: {sum(len(e) for e in emails.values())}")

            save_emails(emails, output_file)

        except Exception as e:
            print(f"Ошибка: {str(e)}")


    if __name__ == '__main__':
        main()