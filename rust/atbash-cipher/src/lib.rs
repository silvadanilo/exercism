static ALPHABET: &'static str = "abcdefghijklmnopqrstuvwxyz";

struct Atbash {
    alphabet: &'static str,
    alphabet_reverted: Vec<u8>
}

impl Atbash {
    fn new(alphabet: &'static str) -> Atbash {
        let rev = ALPHABET.chars().rev();
        let rev_bytes = rev.collect::<String>().into_bytes();

        Atbash {
            alphabet: alphabet,
            alphabet_reverted: rev_bytes
        }
    }

    pub fn is_transposable(&self, c: &char) -> bool {
        c.is_numeric() || self.alphabet.contains(*c)
    }

    pub fn transpose(&self, c: char) -> char {
        if c.is_numeric() {
            c
        } else {
            ALPHABET.find(c).and_then(|i| Some(self.alphabet_reverted[i] as char)).unwrap_or('\'')
        }
    }

}

pub fn encode(plaintext: &str) -> String {
    decode(plaintext)
        .chars()
        .collect::<Vec<char>>()
        .chunks(5)
        .map(|slice| slice.iter().cloned().collect::<String>())
        .collect::<Vec<String>>()
        .join(" ")
}

pub fn decode(s: &str) -> String {
    let cipher = Atbash::new(ALPHABET);

    s.to_lowercase()
        .chars()
        .filter(|c| { cipher.is_transposable(c) })
        .map(|c| {
            cipher.transpose(c)
        })
        .collect::<String>()
}
