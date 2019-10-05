pub struct Roman(u16);

const SYMBOLS: [(u16, &'static str); 13] = [(1, "I"),
                                            (4, "IV"),
                                            (5, "V"),
                                            (9, "IX"),
                                            (10, "X"),
                                            (40, "XL"),
                                            (50, "L"),
                                            (90, "XC"),
                                            (100, "C"),
                                            (400, "CD"),
                                            (500, "D"),
                                            (900, "CM"),
                                            (1000, "M")];

impl Roman {
    pub fn from(n: u16) -> Roman {
        Roman(n)
    }

    pub fn to_string(&self) -> String {
        let mut n = self.0;
        let mut min_numeral = String::new();
        for numeral in SYMBOLS.iter().rev() {
            while numeral.0 <= n {
                min_numeral = min_numeral + numeral.1;
                n -= numeral.0;
            }
        }

        min_numeral
    }
}
