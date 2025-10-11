#task 1
def fib (number):
    a=1
    b=1
    for i in range (2,number):
        sum=a+b
        a=b
        b=sum
    return b
print (fib(6))
# task 1 with *
def fibon_gen(number):
    a=1
    b=1
    for i in range (number):
      yield a
      a,b=b,a+b
for i in fibon_gen(5):
    print (i,end=" ")

# task 2

def convert (text):
    result=0
    i=0
    while i != len(text):
        if text[i]=="I":
            if i==len(text)-1:
                result += 1
            elif text[i+1]!="V" and text [i+1]!="X":
                result+=1
            elif text [i+1]=="V":
                result+=4
                i=i+1
            elif text [i+1]=="X":
                result+=9
                i=i+1
        elif text [i]=="V":
            result+=5

        elif text[i]=="X":
            if i==len (text)-1:
                result += 10
            elif text[i+1]!="L" and text [i+1]!="C":
                result+=10
            elif text [i+1]=="L":
                result+=40
                i=i+1
            elif text [i+1]=="C":
                result+=90
                i=i+1
        elif text [i]=="L":
            result+=50

        elif text[i]=="C":
            if i==len (text)-1:
                result += 100
            elif text[i+1]!="D" and text [i+1]!="M":
                result+=100
            elif text [i+1]=="D":
                result+=400
                i=i+1
            elif text [i+1]=="M":
                result+=900
                i=i+1
        elif text [i]=="D":
            result+=500
        elif text [i]=="M":
            result+=1000
        i=i+1
    print (result)
convert("MCMXCIV")

#task 3
def mon_mass (massive):
    a=True
    b=True
    for i in range (len (massive)-1):
        if massive [i]>massive [i+1]:
            a=False
        if massive [i]<massive [i+1]:
            b=False

    if a==True:
        print (True)
    elif b==True:
        print (True)
    else:
        print (False)
mon_mass([8,2,8,1])

#TASK_2_parsing
import json
import os.path
from datetime import datetime

import requests
from bs4 import BeautifulSoup

class ParserCBRF():
    def __init__(self):
        self.data=[]
    def _parsing (self):
        now=datetime.now().strftime("%d.%m.%Y")
        link=f"https://www.cbr.ru/hd_base/metall/metall_base_new/?UniDbQuery.Posted=True&UniDbQuery.From=01.01.2025&UniDbQuery.To={now}&UniDbQuery.Gold=true&UniDbQuery.Silver=true&UniDbQuery.Platinum=true&UniDbQuery.Palladium=true&UniDbQuery.so=1"
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
                        "Gold":gold if gold else None,
                        "Silver":silver if silver else None,
                        "Platina":platina if platina else None,
                        "Palladiy":palladiy if palladiy else None

                    }
                    self.data.append(file)
    def _save_to_json (self):
        if not os.path.exists("parsed_data"):
            os.makedirs("parsed_data")
        with open ("parsed_data/Metals.json","w") as f:
            json.dump(self.data,f,ensure_ascii=False, indent=2)
    def start(self):
        self._parsing()
        self._save_to_json()

class KeyMetalCBRF ():
    def __init__(self):
        self.data = []
    def keymetalCBRF_by_date (self,date):
        with open ("parsed_data/Metals.json","r") as f:
            self.data=json.load(f)
        print("-----")
        n=False
        for i in self.data:
            if i ["Date"]==date:
                n=True
                print (f"Gold:{i["Gold"]}, Silver: {i["Silver"]}, Platina: {i["Platina"]}, Palladiy: {i["Palladiy"]}")
        if n==False:
            print ("Выберите другую дату")

    def keymetalCBRF_by_period_of_date (self,end_date,start_date):
        with open ("parsed_data/Metals.json","r") as f:
            self.data=json.load(f)
        n=False
        t=False
        for i in self.data:
            if i ["Date"]==start_date:
                n=True
                t=True
                print (f"Date: {i["Date"]},Gold:{i["Gold"]}, Silver: {i["Silver"]}, Platina: {i["Platina"]}, Palladiy: {i["Palladiy"]}")
            elif i ["Date"]==end_date:
                t=False
                print(f"Date: {i["Date"]},Gold:{i["Gold"]}, Silver: {i["Silver"]}, Platina: {i["Platina"]}, Palladiy: {i["Palladiy"]}")
            elif t==True:
                print(f"Date: {i["Date"]},Gold:{i["Gold"]}, Silver: {i["Silver"]}, Platina: {i["Platina"]}, Palladiy: {i["Palladiy"]}")
        if n==False:
            print ("Выберите другую дату")
    def keymetalCBRF_by_last_date(self):
        with open ("parsed_data/Metals.json","r") as f:
            self.data=json.load(f)
        i=self.data[0]
        print (f"Date: {i ["Date"]},Gold:{i["Gold"]}, Silver: {i["Silver"]}, Platina: {i["Platina"]}, Palladiy: {i["Palladiy"]}")




parser=ParserCBRF()
parser.start()
data=KeyMetalCBRF()
data.keymetalCBRF_by_date("06.08.2025")
data.keymetalCBRF_by_period_of_date ("24.09.2025", "03.10.2025")
data.keymetalCBRF_by_last_date()












