def grep(pattern, flags, files):
    collect = []
    flags = _parse_flags(flags, files)

    for file in files:
        collect.append(_grep_on_file(pattern, flags, file))

    return "".join([y for x in collect for y in x])

def _parse_flags(flags, files):
    return {
        'ignore_case': 'i' in flags,
        'line_number': 'n' in flags,
        'file_only': 'l' in flags,
        'entire_line': 'x' in flags,
        'inverse': 'v' in flags,
        'single_file': len(files) == 1
    }


def _format(line_number, line, file, flags):
    if flags['file_only']:
        return file + '\n'
    if flags['line_number']:
        line = f"{line_number}:{line}"

    return f"{line}" if flags['single_file'] else f"{file}:{line}"


def _grep_on_file(pattern, flags, file):
    collect = []
    with open(file, 'r') as file_handle:
        for i, line in enumerate(file_handle):
            if _line_match(pattern, line, flags):
                collect.append(_format(str(i+1), line, file, flags))
                if flags['file_only']:
                    break

    return collect

def _line_match(pattern, line, flags):
    if flags['ignore_case']:
        pattern = pattern.lower()
        line = line.lower()

    if flags['entire_line']:
        pattern += '\n'
        matched = pattern == line
    else:
        matched = pattern in line

    return not matched if flags['inverse'] else matched
