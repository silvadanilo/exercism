const MIN_SQUARE: u32 = 1;
const MAX_SQUARE: u32 = 64;

pub fn square(s: u32) -> u64 {
    if s < MIN_SQUARE || s > MAX_SQUARE {
        panic!("Square must be between 1 and 64");
    }

    2u64.pow(s - 1)
}

pub fn total() -> u64 {
    let max = square(MAX_SQUARE);
    max + (max - 1)
}
