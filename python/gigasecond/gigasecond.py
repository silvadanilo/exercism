import datetime

def add_gigasecond(birth_date):
    return birth_date + datetime.timedelta(0, 10 ** 9)