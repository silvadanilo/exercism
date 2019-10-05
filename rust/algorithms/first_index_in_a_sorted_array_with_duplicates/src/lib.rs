fn first_index_of(list: &[u32], n: u32) -> Option<usize> {
    let mut start = 0;
    let mut end = list.len() - 1;

    while start <= end {
        let middle = (start + end) / 2;
        println!("start => {} | end => {}, middle => {}", start, end, middle);
        if n == list[middle] && (middle == 0 || list[middle -1 ] < n) {
            return Some(middle);
        } else if n <= list[middle] {
            end = middle - 1;
        } else {
            start = middle + 1;
        }
    }

    None
}

#[cfg(test)]
mod tests {
    use first_index_of;

    #[test]
    fn it_works() {
        assert_eq!(0, first_index_of(&[5, 5, 6, 6, 6, 5, 5, 5, 8], 5).unwrap());
        assert_eq!(1, first_index_of(&[2, 5, 5, 6, 6, 5, 5, 5, 8], 5).unwrap());
        assert_eq!(2, first_index_of(&[2, 3, 5, 6, 6, 5, 5, 5, 8], 5).unwrap());
        assert_eq!(3, first_index_of(&[0, 1, 2, 5, 5, 5, 5, 5, 8], 5).unwrap());
        assert_eq!(4, first_index_of(&[0, 1, 2, 2, 5, 5, 5, 5, 8], 5).unwrap());
        assert_eq!(5, first_index_of(&[0, 1, 2, 2, 4, 5, 5, 5, 8], 5).unwrap());
        assert_eq!(6, first_index_of(&[0, 1, 2, 2, 4, 4, 5, 5, 8], 5).unwrap());
        assert_eq!(7, first_index_of(&[0, 1, 2, 2, 4, 4, 4, 5, 8], 5).unwrap());
        assert_eq!(8, first_index_of(&[0, 1, 2, 3, 3, 4, 4, 4, 5], 5).unwrap());
    }
}
