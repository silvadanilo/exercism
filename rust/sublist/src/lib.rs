use std::fmt::Debug;

#[derive(Debug, PartialEq)]
pub enum Comparison {
    Equal,
    Sublist,
    Superlist,
    Unequal,
}

pub fn sublist<T: PartialEq + Debug + Sized>(v1: &[T], v2: &[T]) -> Comparison {
    if v1 == v2 {
        Comparison::Equal
    } else if is_sublist(v1, v2) {
        Comparison::Sublist
    } else if is_sublist(v2, v1) {
        Comparison::Superlist
    } else {
        Comparison::Unequal
    }
}

fn is_sublist<T: PartialEq + Debug + Sized>(v1: &[T], v2: &[T]) -> bool {
    v1.is_empty() || v2.windows(v1.len()).any(|window| {
        v1.iter().zip(window).all(|(x, y)| x == y)
    })
}
