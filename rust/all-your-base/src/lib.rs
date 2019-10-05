///
/// Convert a number between two bases.
///
/// A number is any slice of digits.
/// A digit is any unsigned integer (e.g. u8, u16, u32, u64, or usize).
/// Bases are specified as unsigned integers.
///
/// Return an `Err(.)` if the conversion is impossible.
/// The tests do not test for specific values inside the `Err(.)`.
///
///
/// You are allowed to change the function signature as long as all test still pass.
///
///
/// Example:
/// Input
///   number: &[4, 2]
///   from_base: 10
///   to_base: 2
/// Result
///   Ok(vec![1, 0, 1, 0, 1, 0])
///
/// The example corresponds to converting the number 42 from decimal
/// which is equivalent to 101010 in binary.
///
///
/// Notes:
///  * The empty slice ( "[]" ) is equal to the number 0.
///  * Never output leading 0 digits. However, your function must be able to
///     process input with leading 0 digits.

fn to_dec(number: &[u32], from_base: u32) -> Result<u32, ()> {
    if from_base < 2 || number.iter().any(|n| *n >= from_base) {
        return Err(());
    }

    let len: u32 = number.len() as u32;
    let mut tmp: Vec<u32> = Vec::new();
    for (i, n) in number.iter().enumerate() {
        tmp.push(n * (from_base.pow(len - (i + 1) as u32)));
    }

    let res = tmp.iter().fold(0, |res, n| res + n);

    Ok(res)
}

fn dec_to_base(mut number: u32, to_base: u32) -> Result<Vec<u32>, ()> {
    if to_base < 2 {
        return Err(());
    }

    let mut output_digits: Vec<u32> = Vec::new();

    while number > 0 {
        output_digits.push(number % to_base);
        number = number / to_base;
    }

    output_digits.reverse();
    Ok(output_digits)
}

#[allow(unused_variables)]
pub fn convert(number: &[u32], from_base: u32, to_base: u32) -> Result<Vec<u32>, ()> {
    to_dec(number, from_base).and_then(|number| dec_to_base(number, to_base))
}
