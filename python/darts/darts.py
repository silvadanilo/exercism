SCORES = {1: 10, 5: 5, 10: 1}

def score(x, y):
    distance_from_center = (x ** 2) + (y ** 2)
    for radius, score in SCORES.items():
        if distance_from_center <= radius ** 2:
            return score

    return 0
