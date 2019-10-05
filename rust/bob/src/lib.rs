extern crate regex;
use regex::Regex;

pub fn reply(question: &str) -> &str {
    let constraints = vec![
        ("^$", "Fine. Be that way!"),
        ("^[^a-z]+$", "Whoa, chill out!"),
        ("^.*\\?$", "Sure."),
    ];

    for pair in constraints.into_iter() {
        if Regex::new(pair.0).unwrap().is_match(question) {
            return pair.1;
        }
    }

    "Whatever."
}
