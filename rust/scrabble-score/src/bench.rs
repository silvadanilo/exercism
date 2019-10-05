#![feature(test)]
extern crate test;

pub fn score_iterator(word: &str) -> u16 {
    word.chars().map(|c| charPoint(c)).sum()
}

pub fn score_for(word: &str) -> u16 {
    let mut score = 0;
    for c in word.chars() {
        score += charPoint(c as char);
    }

    score
}

fn charPoint(c: char) -> u16 {
    match c.to_uppercase().next().unwrap() {
        'A' => 1,
        'E' => 1,
        'I' => 1,
        'O' => 1,
        'U' => 1,
        'L' => 1,
        'N' => 1,
        'R' => 1,
        'S' => 1,
        'T' => 1,
        'D' => 2,
        'G' => 2,
        'B' => 3,
        'C' => 3,
        'M' => 3,
        'P' => 3,
        'F' => 4,
        'H' => 4,
        'V' => 4,
        'W' => 4,
        'Y' => 4,
        'K' => 5,
        'J' => 8,
        'X' => 8,
        'Q' => 10,
        'Z' => 10,
        _ => 0,
    }
}

#[cfg(test)]
mod tests {
    use super::*;
    use test::Bencher;

    #[bench]
    fn bench_iterator(b: &mut Bencher) {
        b.iter(|| score_iterator(
            "NON SAPREI QUANTI PUNTI SONO"
        ));
    }

    #[bench]
    fn bench_for(b: &mut Bencher) {
        b.iter(|| score_for(
            "NON SAPREI QUANTI PUNTI SONO"
        ));
    }
}
