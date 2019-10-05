pub fn score(word: &str) -> u16 {
    word.chars().map(|c| charPoint(c)).sum()
}

fn charPoint(c: char) -> u16 {
    match c.to_uppercase().next().unwrap() {
        'A'|'E'|'I'|'O'|'U'|'L'|'N'|'R'|'S'|'T' => 1,
        'D'|'G' => 2,
        'B'|'C'|'M'|'P' => 3,
        'F'|'H'|'V'|'W'|'Y' => 4,
        'K' => 5,
        'J'|'X' => 8,
        'Q'|'Z' => 10,
        _ => 0,
    }
}
