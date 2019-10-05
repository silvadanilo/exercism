#![feature(test)]

use std::thread;
use std::collections::HashMap;
use std::cmp;

pub fn frequency(inputs: &[&'static str], n_workers: usize) -> HashMap<char, usize> {
    let jobs = inputs.len();
    let mut total: HashMap<char, usize> = HashMap::with_capacity(24);
    let mut workers = Vec::with_capacity(n_workers);

    let jobs_for_worker = cmp::max(1, (jobs / n_workers));

    for chunk in inputs.chunks(jobs_for_worker).map(|slice| slice.to_vec()) {
        workers.push(thread::spawn(|| frequency_single_thread(chunk)));
    }

    for worker in workers {
        let partial = worker.join().unwrap();
        for (c, count) in partial {
            *total.entry(c).or_insert(0) += count;
        }
    }

    total
}

fn frequency_single_thread(inputs: Vec<&'static str>) -> HashMap<char, usize> {
    let mut res = HashMap::new();
    for line in inputs {
        for c in line.chars().filter(|c| c.is_alphabetic()).flat_map(|c| c.to_lowercase()) {
            *res.entry(c).or_insert(0) += 1;
        }
    }

    res
}


extern crate test;
#[cfg(test)]
mod tests {
    use test::Bencher;
    use super::*;

    // single process
    // 298,896 ns/iter (+/- 120,996)
    #[bench]
    fn bench_frequency(b: &mut Bencher) {
        let mut v = Vec::with_capacity(1000);
        for _ in 0..1000 {
            v.push("abc");
        }

        b.iter(|| frequency(&v[..], 2));
    }
}
