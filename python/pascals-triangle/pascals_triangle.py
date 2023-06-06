def rows(row_count):
    if row_count < 0:
        raise ValueError("number of rows is negative")
    if row_count == 0:
        return []
    if row_count == 1:
        return [[1]]

    partial = rows(row_count - 1)
    return [*partial, _elements(partial[-1])]


def _elements(previous_row):
    return [1, *[a+b for a,b in zip(previous_row, previous_row[1:])], 1]
