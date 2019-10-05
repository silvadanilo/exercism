#![feature(test)]
extern crate test;

use std::collections::HashMap;

pub fn count(nucleotide: char, dna: &str) -> usize {
    *nucleotide_counts(dna).get(&nucleotide).unwrap()
}

pub fn nucleotide_counts(dna: &str) -> HashMap<char, usize> {
    let mut nucleotides: HashMap<char, usize> = HashMap::with_capacity(4);

    nucleotides.insert('A', 0);
    nucleotides.insert('C', 0);
    nucleotides.insert('G', 0);
    nucleotides.insert('T', 0);

    for ch in dna.chars() {
        let counter = nucleotides.entry(ch).or_insert(0);
        *counter += 1;
    };

    nucleotides
}


pub fn count_2(nucleotide: char, dna: &str) -> usize {
    dna.chars().filter(|c| *c == nucleotide).count()
}

pub fn nucleotide_counts_2(dna: &str) -> HashMap<char, usize> {
    let mut nucleotides: HashMap<char, usize> = HashMap::with_capacity(4);

    for c in "ATCG".chars() {
        nucleotides.insert(c, count_2(c, dna));
    }

    nucleotides
}

pub fn count_3(nucleotide: char, dna: &str) -> usize {
    match nucleotide_counts_3(dna).get(&nucleotide) {
        Some(n) => *n,
        None    =>  0,
    }
}

pub fn nucleotide_counts_3(dna: &str) -> HashMap<char, usize> {
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

#[cfg(test)]
mod tests {
    use super::*;
    use test::Bencher;

    #[bench]
    fn count_1(b: &mut Bencher) {
        b.iter(|| count(
            'G',
            "AGCTTTTCATTCTGACTGCAACGGGCAATATGTCTCTGTGTGGATTAAAAAAAGAGTGTCTGATAGCAGC"
        ));
    }

    #[bench]
    fn count2(b: &mut Bencher) {
        b.iter(|| count_2(
            'G',
            "AGCTTTTCATTCTGACTGCAACGGGCAATATGTCTCTGTGTGGATTAAAAAAAGAGTGTCTGATAGCAGC"
        ));
    }

    #[bench]
    fn count3(b: &mut Bencher) {
        b.iter(|| count_3(
            'G',
            "AGCTTTTCATTCTGACTGCAACGGGCAATATGTCTCTGTGTGGATTAAAAAAAGAGTGTCTGATAGCAGC"
        ));
    }

    #[bench]
    fn nucleotide_counts1(b: &mut Bencher) {
        b.iter(|| nucleotide_counts(
            "AGCTTTTCATTCTGACTGCAACGGGCAATATGTCTCTGTGTGGATTAAAAAAAGAGTGTCTGATAGCAGC"
        ));
    }

    #[bench]
    fn nucleotide_counts2(b: &mut Bencher) {
        b.iter(|| nucleotide_counts_2(
            "AGCTTTTCATTCTGACTGCAACGGGCAATATGTCTCTGTGTGGATTAAAAAAAGAGTGTCTGATAGCAGC"
        ));
    }

    #[bench]
    fn nucleotide_counts3(b: &mut Bencher) {
        b.iter(|| nucleotide_counts_3(
            "AGCTTTTCATTCTGACTGCAACGGGCAATATGTCTCTGTGTGGATTAAAAAAAGAGTGTCTGATAGCAGC"
        ));
    }
}
