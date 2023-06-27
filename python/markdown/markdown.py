import re

def parse(markdown):
    for rule in MARKDOWN_RULES:
        markdown = re.sub(rule[0], rule[1], markdown)

    return markdown

def _header(matches):
    h_tag = f'h{len(matches.group(1))}'
    return f'<{h_tag}>{matches.group(2)}</{h_tag}>'

MARKDOWN_RULES = [
    (re.compile(r'(^#{0,6}) (.*)$', re.M), _header),
    (r'__(.*?)__', '<strong>\\1</strong>'),
    (r'_(.*?)_', '<em>\\1</em>'),
    (re.compile(r'^\* (.*)', re.M), '<li>\\1</li>'),
    (re.compile(r'(<li>.*</li>)', re.S), r'<ul>\1</ul>'),
    (re.compile(r'^(?!<h|<li|<ul)(.*)', re.M), '<p>\\1</p>'),
    (r'\n', ''),
]
