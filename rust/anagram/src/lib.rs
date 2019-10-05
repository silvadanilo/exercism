trait MyStr {
    fn is_anagram_of(&self, string: &str) -> bool;
    fn sorted_chars(&self) -> Vec<char>;
}

impl MyStr for str {
    fn is_anagram_of(&self, candidate: &str) -> bool {
        if candidate.len() != self.len() {
            return false;
        }

        let s1 = self.to_lowercase();
        let s2 = candidate.to_lowercase();

        if s1 == s2 {
            return false;
        }

        s1.sorted_chars() == s2.sorted_chars()
    }

    fn sorted_chars(&self) -> Vec<char> {
        let mut res = self.chars().collect();
        res.sort();
        res
    }
}

pub fn anagrams_for<'a>(origin: &str, candidates: &[&'a str]) -> Vec<&'a str> {
    candidates.iter()
        .filter(|c| c.is_anagram_of(origin))
        .map(|anagram| *anagram)
        .collect()
}
