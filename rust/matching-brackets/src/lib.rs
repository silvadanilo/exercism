// use std::convert::From;

pub struct Brackets(Vec<char>);

impl Brackets {
    pub fn from(s: &'static str) -> Self {
        Brackets(s.chars()
            .filter(|&c| Brackets::is_bracket(c))
            .collect())
    }

    fn is_bracket(c: char) -> bool {
        c == '[' || c == ']' || c == '{' || c == '}' || c == '(' || c == ')'
    }

    pub fn are_balanced(&self) -> bool {
        let mut balanced: Vec<char> = Vec::new();
        for c in &self.0 {
            if Brackets::is_open_bracket(*c) {
                balanced.push(*c);
            } else {
                let last_opened = balanced.pop();
                if last_opened.is_none() {
                    return false;
                }
                if last_opened.unwrap() != Brackets::opposite_of(*c) {
                    return false;
                }
            }
        }

        balanced.is_empty()
    }

    fn opposite_of(c: char) -> char {
        match c {
            '(' => ')',
            ')' => '(',
            '[' => ']',
            ']' => '[',
            '{' => '}',
            '}' => '{',
            _ => panic!("uncovered bracket `{}`", c),
        }
    }

    fn is_open_bracket(c: char) -> bool {
        c == '[' || c == '{' || c == '('
    }
}

// impl From<&'static str> for Brackets {
//     fn from(T) -> Brackets {
//         Brackets("[]")
//     }
// }