class Court_case:
def __init__(self, category, subcategory, court, judge):
    self.category=category
    self.subcategory=subcategory
    self.court=court
    self.judge=judge
    self.is_documents_full = False
    self.decision = ""


def make_a_decision(self, text):
    self.decision = text
    self.is_documents_full = True

def go_to_judge (self,case_number):
    print (f"{self.category} дело о {self.subcategory} направляется в {self.court} судье {self.judge}, ему присваивается {case_number}")
