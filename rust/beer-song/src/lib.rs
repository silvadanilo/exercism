use std::borrow::Cow;

pub fn verse<'a>(verse: u8) -> Cow<'a, str> {
    match verse {
        0 => "No more bottles of beer on the wall, no more bottles of beer.\n\
              Go to the store and buy some more, 99 bottles of beer on the wall.\n\
              ".into(),
        1 => "1 bottle of beer on the wall, 1 bottle of beer.\n\
              Take it down and pass it around, no more bottles of beer on the wall.\n\
              ".into(),
        2 => "2 bottles of beer on the wall, 2 bottles of beer.\n\
              Take one down and pass it around, 1 bottle of beer on the wall.\n\
              ".into(),
        _ => format!(
            "{} bottles of beer on the wall, {} bottles of beer.\n\
             Take one down and pass it around, {} bottles of beer on the wall.\n\
            ",
            verse,
            verse,
            verse -1
        ).into(),
    }
}

pub fn sing<'a>(from: u8, to: u8) -> String {
    // Map-Reduce way
    (to..from).rev()
        .map(|n| verse(n))
        .fold(verse(from).to_string(), |acc, x| format!("{}\n{}", acc, x))


    // // recursive way
    // match from {
    //     0 => verse(0).to_string(),
    //     _ if from == to => verse(from).to_string(),
    //     _ => format!("{}\n{}", verse(from).to_string(), sing(from -1, to))
    // }


    // // non-recursive way
    // let mut output = verse(from).to_string();
    // for i in (to..from).rev() {
    //     output.push_str("\n");
    //     output.push_str(&verse(i));
    // }

    // output.to_owned()
}
