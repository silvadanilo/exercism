import re
from collections import Counter

def count_words(phrase):
    splitted = re.findall(r"([a-z0-9]+(?:\'[a-z0-9]+)?)", phrase.lower())
    return Counter(splitted)
