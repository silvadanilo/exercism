#![feature(inclusive_range_syntax)]

pub fn square_of_sum(n: i32) -> i32 {
    let sum: i32 = (0...n).sum();
    sum.pow(2)
}

pub fn sum_of_squares(n: i32) -> i32 {
    (1...n).map(|x| x.pow(2)).fold(0, |acc, x| acc + x)
}

pub fn difference(n: i32) -> i32 {
    square_of_sum(n) - sum_of_squares(n)
}
