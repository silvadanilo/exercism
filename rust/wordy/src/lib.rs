use std::str::FromStr;

#[derive(Debug, Clone, Copy)]
enum Operation {
    PLUS,
    MINUS,
    MULTIPLY,
    DIVIDE,
}
impl FromStr for Operation {
    type Err = ();

    fn from_str(s: &str) -> Result<Operation, ()> {
        match s {
            "plus" => Ok(Operation::PLUS),
            "minus" => Ok(Operation::MINUS),
            "multiplied" => Ok(Operation::MULTIPLY),
            "divided" => Ok(Operation::DIVIDE),
            _ => Err(()),
        }
    }
}

#[derive(Debug)]
enum Parsed {
    VALUE(i64),
    OPERATION(Operation),
}

impl FromStr for Parsed {
    type Err = ();
    fn from_str<'a>(s: &'a str) -> Result<Self, Self::Err> {

        let parse_i64 = |s: &'a str| -> Result<Parsed, &'a str> {
            s.parse().map(|i| Parsed::VALUE(i)).map_err(|_| s)
        };

        let parse_operation = |s: &'a str| -> Result<Parsed, Self::Err> {
            s.parse()
                .map(|i: Operation| Parsed::OPERATION(i))
                .map_err(|_| ())
        };

        parse_i64(s).or_else(parse_operation)
    }
}

pub struct WordProblem {
    command: &'static str,
    next_operation: Operation,
}

impl WordProblem {
    pub fn new(command: &'static str) -> Self {
        WordProblem {
            command: command
                .trim_left_matches("What is ")
                .trim_right_matches('?'),
            next_operation: Operation::PLUS,
        }
    }

    pub fn answer(&mut self) -> Result<i64, &'static str> {
        let operations = self.command
            .split_whitespace()
            .filter_map(|word| word.parse().ok())
            .collect::<Vec<Parsed>>();

        if operations.iter()
            .find(|&o| if let &Parsed::OPERATION(_) = o {
                true
            } else {
                false
            })
            .is_none() {
            return Err("unknown operation");
        }

        Ok(operations.iter()
            .fold(0, |res, p| {
                self.process(res, p)
            }))
    }

    fn next_operation(&mut self, next: Operation) {
        self.next_operation = next;
    }

    fn process(&mut self, res: i64, p: &Parsed) -> i64 {
        match *p {
            Parsed::VALUE(x) => {
                match self.next_operation {
                    Operation::PLUS => res + x,
                    Operation::MINUS => res - x,
                    Operation::MULTIPLY => res * x,
                    Operation::DIVIDE => res / x,
                }
            }
            Parsed::OPERATION(o) => {
                self.next_operation(o);
                res
            }
        }
    }
}
