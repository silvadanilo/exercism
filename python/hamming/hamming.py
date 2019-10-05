def distance(original, to_compare):
    if len(original) != len(to_compare):
        raise ValueError

    distance = 0;
    for comp in zip(original, to_compare):
        if comp[0] != comp[1]:
            distance += 1

    return distance;