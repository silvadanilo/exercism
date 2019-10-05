use std::collections::HashMap;

pub fn count(nucleotide: char, dna: &str) -> usize {
    match nucleotide_counts_3(dna).get(&nucleotide) {
        Some(n) => *n,
        None    =>  0,
    }
}

pub fn nucleotide_counts(dna: &str) -> HashMap<char, usize> {
    let mut nucleotides: HashMap<char, usize> = HashMap::with_capacity(4);
    let mut a: usize = 0;
    let mut c: usize = 0;
    let mut g: usize = 0;
    let mut t: usize = 0;

    for ch in dna.chars() {
        match ch {
            'A' => a += 1,
            'C' => c += 1,
            'G' => g += 1,
            'T' => t += 1,
            _   => ()
        }
    };

    nucleotides.insert('A', a);
    nucleotides.insert('C', c);
    nucleotides.insert('G', g);
    nucleotides.insert('T', t);

    nucleotides
}
