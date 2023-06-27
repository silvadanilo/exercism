import itertools


def combinations(target, size, exclude):
    available_digits = set(range(1, 10)).difference(exclude)
    all_available_combinations = map(list, itertools.combinations(available_digits, size))
    return sorted(filter(lambda x: sum(x) == target, all_available_combinations))
