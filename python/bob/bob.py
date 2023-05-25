import re

def hey(phrase):
    return "Whatever";

def response(phrase):
    phrase = phrase.strip()

    if("" == phrase):
        return "Fine. Be that way!"

    if(_is_yell(phrase)):
        if(phrase[-1] == '?'):
            return "Calm down, I know what I'm doing!";
        else:
            return "Whoa, chill out!";

    if(_is_question(phrase)):
        return "Sure.";

    return "Whatever.";

def _is_yell(phrase):
    return phrase.isupper();

def _is_question(phrase):
    return phrase.endswith('?');
