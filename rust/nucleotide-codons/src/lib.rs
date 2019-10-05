pub struct Codons<'a> {
    vocabulary: Vec<(&'a str, &'a str)>,
    to_be_expanded_chars: Vec<(char, Vec<char>)>
}

impl<'a> Codons<'a> {
    pub fn name_for(&self, nucleotide: &str) -> Result<&str, ()> {
        let n = self.vocabulary
            .iter()
            .find(|&&(codon, _name)| self.expand(nucleotide).binary_search(&codon.to_string()).is_ok());

        match n {
            Some(&(_codon, name)) => Ok(name),
            None => Err(())
        }
    }

    fn expand<'b>(&self, nucleotide: &'b str) -> Vec<String> {
        let mut expanded = vec![nucleotide.clone().to_string()];

        for &(expandable, ref into) in self.to_be_expanded_chars.iter() {
            if nucleotide.contains(expandable) {
                let candidates = expanded.clone();
                expanded = into.iter()
                    .map(|c| {
                        candidates.iter()
                            .map(move |nucleotide| nucleotide.replace(expandable, &c.to_string()))
                            .collect::<Vec<String>>()
                    })
                    .fold(expanded, |mut acc, ref mut it| {
                        acc.append(it);
                        acc
                    });
            }
        };

        expanded
    }
}

pub fn parse<'a>(vocabulary: Vec<(&'a str, &'a str)>) -> Codons<'a> {
    Codons {
        vocabulary: vocabulary,
        to_be_expanded_chars: vec![
            ('W', vec!['A', 'T']),
            ('S', vec!['C', 'G']),
            ('M', vec!['A', 'C']),
            ('K', vec!['G', 'T']),
            ('R', vec!['A', 'G']),
            ('Y', vec!['C', 'T']),
            ('B', vec!['C', 'G', 'T']),
            ('D', vec!['A', 'G', 'T']),
            ('H', vec!['A', 'C', 'T']),
            ('V', vec!['A', 'C', 'G']),
            ('N', vec!['A', 'C', 'G', 'T']),
        ]
    }
}
