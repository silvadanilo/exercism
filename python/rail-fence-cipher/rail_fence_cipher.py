import itertools

def _sequence(n_rails, message_lenght):
    sequence = list(range(n_rails))
    sequence = sequence + sequence[-2:0:-1]
    cycle = itertools.cycle(sequence)
    return sorted([(next(cycle), i) for i in range(message_lenght)])

def encode(message, n_rails):
    sequence = _sequence(n_rails, len(message))
    return ''.join([message[char_at] for _, char_at in sequence])

def decode(encoded_message, n_rails):
    sequence = _sequence(n_rails, len(encoded_message))
    encoded_message_sequence = zip(encoded_message, sequence)
    return ''.join([c for c, _ in sorted(encoded_message_sequence, key=lambda x: x[1][1])])
