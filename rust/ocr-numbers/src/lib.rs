use std::str::FromStr;

struct Digit(char);
impl FromStr for Digit {
    type Err = ();

    fn from_str(s: &str) -> Result<Self, Self::Err> {
        let c = match s {
            " _ | ||_|   " => '0',
            "     |  |   " => '1',
            " _  _||_    " => '2',
            " _  _| _|   " => '3',
            "   |_|  |   " => '4',
            " _ |_  _|   " => '5',
            " _ |_ |_|   " => '6',
            " _   |  |   " => '7',
            " _ |_||_|   " => '8',
            " _ |_| _|   " => '9',
            _ => '?',
        };

        Ok(Digit(c))
    }
}

// fn into_vec_of_single_digit(lines: Vec<&str>) -> Vec<String> {
fn into_vec_of_single_digit(lines: &[&str]) -> Vec<String> {
    let mut single_digits: Vec<String> = vec![String::new(); lines[0].len() / 3];

    for l in lines {
        l.chars().collect::<Vec<char>>().chunks(3).into_iter().enumerate().fold(&mut single_digits, |acc, (i, chars)| {
            let line = chars.iter().fold(String::new(), |mut acc, c| {
                acc.push(*c);
                acc
            });
            acc[i].push_str(&line);
            acc
        });
    }

    single_digits
}

pub fn convert(input: &str) -> Result<String, ()> {
    let lines = input.lines().collect::<Vec<&str>>();

    if 0 != lines.len() % 4 {
        return Err(());
    }

    if lines.iter().any(|l| 0 != l.len() % 3) {
        return Err(());
    }

    let s: Vec<String> = lines.chunks(4).map(|c| {
        into_vec_of_single_digit(c).iter()
            .map(|seven_segment_digit| {
                seven_segment_digit.parse::<Digit>()
            })
            .fold(String::new(), |mut s, d| {
                s.push(d.unwrap().0);
                s
            })
    }).collect();

    Ok(s.join(","))
}
