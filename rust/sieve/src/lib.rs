pub fn primes_up_to(limit: u32) -> Vec<u32> {
    let mut primes = Vec::new();
    let mut number_list: Vec<u32> = (2..limit + 1).collect();

    while !number_list.is_empty() {
        let next_prime = number_list.remove(0);
        number_list.retain(|&x| x % next_prime != 0);
        primes.push(next_prime);
    }

    primes
}
