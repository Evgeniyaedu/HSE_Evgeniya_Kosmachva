class CourtCase:
    def __init__(self, case_number):
        self.case_number = case_number
        self.case_participants=[]
        self.listening_datetimes=[]
        self.is_finished=False
        self.verdict=""
    def set_a_listening_datetime (self,date):
        self.listening_datetimes.append(date)

    def add_participants (self, INN):
        self.case_participants.append(INN)

    def remove_participants (self,INN):
        if INN in self.case_participants:
            self.case_participants.remove (INN)
        else:
            print ("Участника нет в БД")

    def make_a_decision (self, text):
        self.verdict=text
        self.is_finished=True

    def info (self): # для вывода всей информации
        print (self.case_number, self.listening_datetimes, self.case_participants,self.verdict, self.is_finished)

a=CourtCase(input("Введите номер дела: "))
a.info()
a.set_a_listening_datetime("21.02.2021")
a.info()
a.add_participants ("5959123321")
a.info()
a.remove_participants("595912331")
a.info()
a.make_a_decision("Иск удовлетворить полностью")
a.info()