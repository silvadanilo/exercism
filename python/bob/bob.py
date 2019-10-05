def hey(phrase):
    phrase = phrase.strip()

    if not phrase:
        return "Fine. Be that way!"

    if (is_yell(phrase)):
        return "Whoa, chill out!"

    if (is_question(phrase)):
        return "Sure."

    return "Whatever."

def is_question(phrase):
    return phrase.endswith('?')

def is_yell(phrase):
    return phrase.isupper()