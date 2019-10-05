#[derive(Debug, PartialEq, Eq, Copy, Clone)]
pub enum Allergen {
    Eggs,
    Peanuts,
    Shellfish,
    Strawberries,
    Tomatoes,
    Chocolate,
    Pollen,
    Cats,
}

static POINTS: [(Allergen, u16); 8] = [
    (Allergen::Eggs, 1),
    (Allergen::Peanuts, 2),
    (Allergen::Shellfish, 4),
    (Allergen::Strawberries, 8),
    (Allergen::Tomatoes, 16),
    (Allergen::Chocolate, 32),
    (Allergen::Pollen, 64),
    (Allergen::Cats, 128)
];

#[derive(Debug, PartialEq, Eq)]
pub struct Allergies {
    point: u16,
}

impl Allergies {
    pub fn new(point: u16) -> Self {
        Allergies { point: point }
    }

    pub fn is_allergic_to(&self, allergen: &Allergen) -> bool {
       POINTS
            .iter()
            .find(|&&(ref a, _)| allergen == a)
            .map(|&allergen_point| self.in_use(allergen_point))
            .unwrap_or(false)
    }

    pub fn allergies(&self) -> Vec<Allergen> {
        POINTS
            .iter()
            .filter(|&&allergen_point| self.in_use(allergen_point))
            .map(|&(ref allergene, _)| allergene.clone())
            .collect()
    }

    fn in_use(&self, allergen_point: (Allergen, u16)) -> bool {
        self.point & allergen_point.1 == allergen_point.1
    }
}
