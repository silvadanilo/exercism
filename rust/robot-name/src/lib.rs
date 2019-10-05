extern crate rand;

use rand::Rng;

pub struct Robot {
    name: String,
}

impl Robot {
    pub fn new() -> Robot {
        Robot { name: Self::random_name() }
    }

    pub fn name<'a>(&'a self) -> &'a str {
        &self.name
    }

    pub fn reset_name(&mut self) {
        self.name = Self::random_name();
    }

    fn random_name() -> String {
        let mut rng = rand::thread_rng();

        format!("{}{:03}",
                rng.gen_ascii_chars()
                    .filter(|x| x.is_uppercase())
                    .take(2)
                    .collect::<String>(),
                rng.gen_range(0, 1000))
    }
}
