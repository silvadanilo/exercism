pub fn raindrops(input: i32) -> String {
    let constraints = vec![
        (3, "Pling"),
        (5, "Plang"),
        (7, "Plong"),
    ];

    let mut output = String::new();

    for pair in constraints.into_iter() {
        if input % pair.0  == 0 {
            output.push_str(pair.1);
        }
    }

    if output.is_empty() {
        return input.to_string()
    }

    output
}
