def translate(text):
    words = text.split(" ")
    translated_words = [_translate_word(word) for word in words]
    return " ".join(translated_words)


def _translate_word(word):
    if _start_with_vowel(word):
        return word + "ay"
    elif word[:2] == "qu":
        return word[2:] + "quay"
    elif word[1] == "q" and word[2] == "u":
        return word[3:] + word[0] + "quay"
    elif word[0] == "y":
        return word[1:] + "yay"
    else:
        return _move_consonant_to_the_end(word) + "ay"


def _move_consonant_to_the_end(text):
    if text[0] in "aeiouy":
        return text
    else:
        return _move_consonant_to_the_end(text[1:] + text[0])


def _start_with_vowel(word):
    return word[0] in "aeiou" or word[:2] in ["xr", "yt"]
