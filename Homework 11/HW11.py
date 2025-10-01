# task 1
import requests
from typing import Dict, Any, Optional, List


class LegalAPI:

    def __init__(self, token: str):
        self.base_url = "https://legal-api.sirotinsky.com"
        self.token = token
        self.headers = {
            "Authorization": f"Bearer {token}",
            "Content-Type": "application/json"
        }

    def _make_request(self, endpoint: str, params: Optional[Dict] = None) -> Dict[str, Any]:

        url = f"{self.base_url}{endpoint}"
        try:
            response = requests.get(url, headers=self.headers, params=params)
            response.raise_for_status()
            return response.json()
        except requests.exceptions.RequestException as e:
            raise Exception(f"Ошибка при выполнении запроса: {e}")

    def get_efrsb_publications(self, page: int = 1, size: int = 10) -> Dict[str, Any]:

        params = {"page": page, "size": size}
        return self._make_request("/api/efrsb/publications", params)

    def get_efrsb_publication_by_id(self, publication_id: str) -> Dict[str, Any]:

        return self._make_request(f"/api/efrsb/publications/{publication_id}")

    def search_efrsb_publications(self, query: str, page: int = 1, size: int = 10) -> Dict[str, Any]:

        params = {"q": query, "page": page, "size": size}
        return self._make_request("/api/efrsb/publications/search", params)

    def get_efrsb_debtors(self, page: int = 1, size: int = 10) -> Dict[str, Any]:
        "
        params = {"page": page, "size": size}
        return self._make_request("/api/efrsb/debtors", params)

    def get_efrsb_debtor_by_inn(self, inn: str) -> Dict[str, Any]:

        return self._make_request(f"/api/efrsb/debtors/{inn}")

    def search_efrsb_debtors(self, query: str, page: int = 1, size: int = 10) -> Dict[str, Any]:
        params = {"q": query, "page": page, "size": size}
        return self._make_request("/api/efrsb/debtors/search", params)

    def get_efrsb_arbitration_managers(self, page: int = 1, size: int = 10) -> Dict[str, Any]:

        params = {"page": page, "size": size}
        return self._make_request("/api/efrsb/arbitration-managers", params)

    def get_efrsb_arbitration_manager_by_id(self, manager_id: str) -> Dict[str, Any]:

        return self._make_request(f"/api/efrsb/arbitration-managers/{manager_id}")

    def get_efrsb_bankruptcy_cases(self, page: int = 1, size: int = 10) -> Dict[str, Any]:

        params = {"page": page, "size": size}
        return self._make_request("/api/efrsb/bankruptcy-cases", params)

    def get_efrsb_bankruptcy_case_by_id(self, case_id: str) -> Dict[str, Any]:

        return self._make_request(f"/api/efrsb/bankruptcy-cases/{case_id}")

    def get_efrsb_trades(self, page: int = 1, size: int = 10) -> Dict[str, Any]:

        params = {"page": page, "size": size}
        return self._make_request("/api/efrsb/trades", params)

    def get_efrsb_trade_by_id(self, trade_id: str) -> Dict[str, Any]:

        return self._make_request(f"/api/efrsb/trades/{trade_id}")

    def get_efrsb_statistics(self) -> Dict[str, Any]:

        return self._make_request("/api/efrsb/statistics")



if __name__ == "__main__":
    token = "4123saedfasedfsadf4324234f223ddf23"
    api_client = LegalAPI(token)

    try:
        publications = api_client.get_efrsb_publications(page=1, size=5)
        print("Публикации:", publications)

        debtors = api_client.search_efrsb_debtors("ООО", page=1, size=5)
        print("Должники:", debtors)

        statistics = api_client.get_efrsb_statistics()
        print("Статистика:", statistics)

    except Exception as e:
        print(f"Ошибка при работе с API: {e}")