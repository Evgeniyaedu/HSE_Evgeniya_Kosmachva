"""Nasdaq (https://www.nasdaq.com/)

Основные API:

https://api.nasdaq.com/api/quote/[SYMBOL]/info - информация об акции
https://api.nasdaq.com/api/quote/[SYMBOL]/chart - графики и исторические данные
https://api.nasdaq.com/api/quote/[SYMBOL]/summary - сводка по акции
https://api.nasdaq.com/api/screener/stocks - скринер акций


2. LME

Основные API:

https://www.lme.com/api/landing-pages - основные данные
https://www.lme.com/api/trading-data/day-delayed - торговые данные
https://www.lme.com/api/MetalPrices - цены на металлы
https://www.lme.com/api/lme-base-prices - базовые цены


3. 5ka.ru

Основные API:

https://5ka.ru/api/v2/special_offers/ - акционные предложения
https://5ka.ru/api/v2/categories/ - категории товаров
https://5ka.ru/api/v2/stores/ - информация о магазинах
https://5ka.ru/api/v2/products/ - продукты
Особенности: Относительно открытое API с пагинацией

4. Федресурс (https://fedresurs.ru/)

Основные API:

https://fedresurs.ru/backend/companies/[INN] - данные по компаниям
https://fedresurs.ru/backend/sfactmessages/[ID] - сообщения о банкротствах
https://fedresurs.ru/backend/publications - публикации


5. Картотека арбитражных дел (https://kad.arbitr.ru/)

Основные API:

https://kad.arbitr.ru/Card/GetCases - получение дел
https://kad.arbitr.ru/Card/GetCard/[CASE_ID] - карточка дела
https://kad.arbitr.ru/Card/GetDocuments/[CASE_ID] - документы по делу"""

import requests
import json


def get_5ka_special_offers(page=1, records_per_page=20):
    """Получение акционных предложений с 5ka.ru"""
    url = 'https://5ka.ru/api/v2/special_offers/'

    params = {
        'page': page,
        'records_per_page': records_per_page
    }

    headers = {
        'User-Agent': 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36',
        'Accept': 'application/json'
    }

    try:
        response = requests.get(url, params=params, headers=headers, timeout=10)
        response.raise_for_status()
        return response.json()
    except requests.exceptions.RequestException as e:
        print(f"Ошибка запроса: {e}")
        return None


def get_5ka_categories():
    """Получение категорий товаров"""
    url = 'https://5ka.ru/api/v2/categories/'

    headers = {
        'User-Agent': 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36'
    }

    try:
        response = requests.get(url, headers=headers, timeout=10)
        response.raise_for_status()
        return response.json()
    except requests.exceptions.RequestException as e:
        print(f"Ошибка запроса: {e}")
        return None


# Пример запроса к 5-ке
if __name__ == "__main__":
    offers = get_5ka_special_offers()
    if offers:
        print("Акционные предложения:")
        for offer in offers.get('results', [])[:5]:
            print(f"- {offer.get('name', '')}: {offer.get('current_prices', {}).get('price_reg__min', '')} руб.")


    categories = get_5ka_categories()
    if categories:
        print("\nКатегории товаров:")
        for category in categories[:5]:
            print(f"- {category.get('name', '')}")