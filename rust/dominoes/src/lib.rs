#![feature(test)]

type Stone = (usize, usize);

pub fn sort(head: usize, tail: usize, stones: &[Stone]) -> Option<Vec<Stone>> {
    if stones.is_empty() {
        return Some(Vec::new());
    }

    for (i, &stone) in stones.iter().enumerate() {
        let next_stone = match tail {
            x if x == stone.0 => stone,
            x if x == stone.1 => (stone.1, stone.0),
            _ => {
                continue;
            }
        };

        let mut stones = stones.to_vec();
        stones.remove(i);
        match sort(head, next_stone.1, &stones) {
            Some(mut x) => {
                x.insert(0, next_stone);
                return Some(x);
            }
            None => {}
        }
    }

    None
}

pub fn chain(stones: &Vec<Stone>) -> Option<Vec<Stone>> {
    if stones.is_empty() {
        return Some(vec![]);
    }

    let first = stones[0];
    sort(first.0, first.1, &stones[1..])
        .map(|mut x| {
            x.insert(0, first);
            x
        })
        .and_then(|x| {
            if x[0].0 != x.last().unwrap().1 {
                None
            } else {
                Some(x)
            }
        })
}

extern crate test;
#[cfg(test)]
mod tests {
    use test::Bencher;
    use super::*;

    #[bench]
    fn bench_chain(b: &mut Bencher) {
        let input = vec![(1, 2), (5, 3), (3, 1), (1, 2), (2, 4), (1, 6), (2, 3), (3, 4), (5, 6)];
        b.iter(|| chain(&input));
    }
}
