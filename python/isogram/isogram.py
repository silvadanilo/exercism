def is_isogram(string):
    if not string:
        return True;

    s = set();
    for c in string.lower():
        if (not c.isalnum()):
            continue;
        if (c in s):
            return False

        s.add(c);

    return True