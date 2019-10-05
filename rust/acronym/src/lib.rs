pub fn abbreviate(long_version: &str) -> String {
    let mut last_char = ' ';
    long_version.chars()
        .filter(|c| {
            let is_part_of_acronym = match last_char {
                ' ' | '-' => true,
                _ => c.is_uppercase() && !last_char.is_uppercase()
            };

            last_char = *c;
            is_part_of_acronym
        })
        .map(|c| c.to_string().to_uppercase())
        .fold(String::new(), |mut acronym, c| {
            acronym += &c;
            acronym
        })
}

// fn is_part_of_acronym(c: char, last_char: char) -> bool {
//     match last_char {
//         ' ' | '-' => true,
//         _ => c.is_uppercase() && !last_char.is_uppercase()
//     }
// }
