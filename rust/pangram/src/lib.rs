pub fn is_pangram(sentence: &str) -> bool {
    let sentence = sentence.to_lowercase();
    "abcdefghijklmnopqrstuvwxyz".chars().all(|c| {
        sentence.contains(c)
    })
}
