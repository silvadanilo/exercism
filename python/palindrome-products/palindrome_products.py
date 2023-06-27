import itertools
from math import ceil


def largest(min_factor, max_factor):
    """Given a range of numbers, find the largest palindromes which
       are products of two numbers within that range.

    :param min_factor: int with a default value of 0
    :param max_factor: int
    :return: tuple of (palindrome, iterable).
             Iterable should contain both factors of the palindrome in an arbitrary order.
    """

    return _select(min_factor, max_factor, descending=True)


def smallest(min_factor, max_factor):
    """Given a range of numbers, find the smallest palindromes which
    are products of two numbers within that range.

    :param min_factor: int with a default value of 0
    :param max_factor: int
    :return: tuple of (palindrome, iterable).
    Iterable should contain both factors of the palindrome in an arbitrary order.
    """

    return _select(min_factor, max_factor, descending=False)


def _select(min_factor, max_factor, descending):
    if min_factor > max_factor:
        raise ValueError("min must be <= max")

    factors = range(min_factor, max_factor + 1)
    if descending:
        products = range(pow(max_factor, 2), pow(min_factor, 2) - 1, -1)
    else:
        products = range(pow(min_factor, 2), pow(max_factor, 2) + 1)

    for product in products:
        if is_palindrome([product]):
            print(product)
            result = []
            for factor in factors:
                if product % factor == 0 and product / factor in factors:
                    result.append([factor, product / factor])
            if len(result):
                return (product, result)

    return (None, [])


def is_palindrome(tuple):
    s = str(tuple[0])
    return s[: len(s) // 2] == s[-1 : ceil(len(s) / 2) - 1 : -1]
