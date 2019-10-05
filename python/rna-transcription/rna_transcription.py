import re

def to_rna(dna):
    if not is_valid(dna):
        return '';

    rep = {'G' : 'C', 'C' : 'G', 'T': 'A', 'A' : 'U'}
    rep = dict((re.escape(k), v) for k, v in rep.iteritems())
    pattern = re.compile("|".join(rep.keys()))
    rna = pattern.sub(lambda m: rep[re.escape(m.group(0))], dna)
    return rna;

def is_valid(dna):
    nucleotides = ('A','C','G','T')
    return all(n in nucleotides for n in dna);