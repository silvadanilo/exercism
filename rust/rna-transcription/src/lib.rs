#[derive(PartialEq, Debug)]
pub struct RibonucleicAcid(String);

impl RibonucleicAcid {
    pub fn new (strand: &str) -> Self {
        RibonucleicAcid(strand.to_string())
    }
}

#[derive(PartialEq, Debug)]
pub struct DeoxyribonucleicAcid(String);

impl DeoxyribonucleicAcid {
    pub fn new (strand: &str) -> Self {
        DeoxyribonucleicAcid(strand.to_string())
    }

    pub fn to_rna(&self) -> RibonucleicAcid {
        let rna_strand: String = self.0.chars().map(|c| {
            match c {
                'G' => 'C',
                'C' => 'G',
                'T' => 'A',
                'A' => 'U',
                _ => panic!("{} is not a valid nucleotide", c)
            }
        }).collect::<String>();

        RibonucleicAcid::new(&rna_strand)
    }
}
