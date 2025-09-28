import json
import requests
from bs4 import BeautifulSoup

class ParserCBRF():
    def __init__(self):
        self.data=[]
    def _parsing (self):
        link="https://www.cbr.ru/hd_base/metall/metall_base_new/?UniDbQuery.Posted=True&UniDbQuery.From=01.08.2025&UniDbQuery.To=31.08.2025&UniDbQuery.Gold=true&UniDbQuery.Silver=true&UniDbQuery.Platinum=true&UniDbQuery.Palladium=true&UniDbQuery.so=1"
        response=requests.get(link,headers={"user_agent":"Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36"})
        soup=BeautifulSoup(response.content,"html.parser")
        table=soup.find("table",{"class":"data"})
        if table:
            print ("Date        | Gold          | Silver            | Platina          | Palladiy         ")
            print ("-"*100)
            for row in table.find_all("tr"):
                cols=row.find_all("td")
                if len(cols)>=5:
                    date=cols[0].text.strip()
                    gold=cols[1].text.strip().replace(",",".").replace(" ", "")
                    silver=cols[2].text.strip().replace(",",".").replace(" ", "")
                    platina=cols[3].text.strip().replace(",",".").replace(" ", "")
                    palladiy=cols[4].text.strip().replace(",",".").replace(" ", "")
                    print (f"{date}|{gold:15}|{silver:15}|{platina:15}|{palladiy:15}")
                    file={
                        "Date":date,
                        "Gold":float(gold) if gold else None,
                        "Silver": float(silver) if silver else None,
                        "Platina": float(platina) if platina else None,
                        "Palladiy": float(palladiy) if palladiy else None

                    }
                    self.data.append(file)
    def _save_to_json (self):
        with open ("Metals.json","w") as f:
            json.dump(self.data,f,ensure_ascii=False, indent=2)
    def start(self):
        self._parsing()
        self._save_to_json()
parser=ParserCBRF()
parser.start()
