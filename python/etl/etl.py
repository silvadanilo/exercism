def transform(legacy_data):
    # acc = {}
    # for score, letters in legacy_data.items():
    #     for letter in letters:
    #         acc[letter.lower()] = score

    # return acc
    return { letter.lower(): score for score, letters in legacy_data.items() for letter in letters}
