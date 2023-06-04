COLORS = [
    "black",
    "brown",
    "red",
    "orange",
    "yellow",
    "green",
    "blue",
    "violet",
    "grey",
    "white"
]

def color_code(color: str) -> int:
    return COLORS.index(color)


def colors() -> list:
    return COLORS
