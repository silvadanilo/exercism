#![feature(alloc_system)]
extern crate alloc_system;

use std::cell::Cell;

#[derive(Debug, Clone, Copy)]
enum Kind {
    NotPrime,
    Unknown,
}

#[derive(Debug, Clone, Copy)]
struct Number {
    marked_as: Kind,
    number: u32,
}

impl Number {
    fn mark(mut self) -> Self {
        self.marked_as = Kind::NotPrime;
        self
    }

    fn new(n: u32) -> Self {
        Number {
            marked_as: Kind::Unknown,
            number: n,
        }
    }

    fn is_not_prime(&self) -> bool {
        match self.marked_as {
            Kind::NotPrime => true,
            _ => false,

        }
    }

    fn is_divisible_by(&self, x: &Number) -> bool {
        self.number % x.number == 0
    }
}

pub fn primes_up_to(limit: u32) -> Vec<u32> {
    let mut primes = Vec::new();
    let number_list: Vec<Cell<Number>> = (2..limit + 1)
        .map(|i| Cell::new(Number::new(i)))
        .collect();

    for n in number_list.iter()
        .map(|x| x.get())
        .filter(|x| !x.is_not_prime()) {

        for m in number_list.iter()
            .filter(|x| x.get().number != n.number)
            .filter(|x| x.get().is_divisible_by(&n)) {
            m.set(m.get().mark());
        }

        primes.push(n.number);
    }

    primes
}
