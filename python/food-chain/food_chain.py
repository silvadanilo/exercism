from functools import reduce

ANIMALS = [
    ("fly", None, "I don't know why she swallowed the fly. Perhaps she'll die."),
    ("spider", "It wriggled and jiggled and tickled inside her.", None),
    (
        "bird",
        "How absurd to swallow a bird!",
        "She swallowed the bird to catch the spider that wriggled and jiggled and tickled inside her.",
    ),
    ("cat", "Imagine that, to swallow a cat!", None),
    ("dog", "What a hog, to swallow a dog!", None),
    ("goat", "Just opened her throat and swallowed a goat!", None),
    ("cow", "I don't know how she swallowed a cow!", None),
    ("horse", None, "She's dead, of course!"),
]


def verse(verse_i):
    return list(
        filter(
            lambda x: x != None,
            [
                f"I know an old lady who swallowed a {ANIMALS[verse_i][0]}.",
                ANIMALS[verse_i][1],
                *_recursive_ends(verse_i),
            ],
        )
    )


def _recursive_ends(verse_i):
    end_verse = [
        ANIMALS[verse_i][2]
        or f"She swallowed the {ANIMALS[verse_i][0]} to catch the {ANIMALS[verse_i - 1][0]}."
    ]

    if 0 < verse_i < 7:
        return end_verse + _recursive_ends(verse_i - 1)

    return end_verse


def recite(start_verse, end_verse):
    return reduce(
        lambda a, b: a + [""] + b,
        [verse(verse_i) for verse_i in range(start_verse - 1, end_verse)],
    )
