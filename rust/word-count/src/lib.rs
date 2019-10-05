use std::collections::HashMap;

pub fn word_count(string: &str) -> HashMap<String, u32> {
    let mut counts: HashMap<String, u32> = HashMap::new();

    for word in string.to_lowercase()
        .split(|c: char| !c.is_alphanumeric())
        .filter(|word| !word.is_empty()) {
            *counts.entry(word.to_string()).or_insert(0) += 1;
    }

    counts
}
