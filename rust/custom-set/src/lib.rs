use std::fmt::Debug;
use std::iter::FromIterator;

#[derive(Debug, Clone)]
pub struct CustomSet<T>(Vec<T>);

impl<T: PartialEq + Debug + Copy> PartialEq for CustomSet<T> {
    fn eq(&self, other: &CustomSet<T>) -> bool {
        if self.is_empty() && other.is_empty() {
            return true;
        }

        match (self.len(), other.len()) {
            (x, y) if x == y => {
                self.0.iter().all(|e| {
                    other.contains(e)
                })
            },
            (_ ,_) => false
        }
    }
}

impl<T: PartialEq + Debug + Copy> FromIterator<T> for CustomSet<T> {
    fn from_iter<I: IntoIterator<Item = T>>(iter: I) -> Self {
        let mut set = CustomSet(vec![]);
        for e in iter {
            set.add(e);
        }
        set
    }
}


impl<T: PartialEq + Debug + Sized + Clone + Copy> CustomSet<T> {
    pub fn new(data: Vec<T>) -> Self {
        data.iter().cloned().collect()
    }

    pub fn is_empty(&self) -> bool {
        self.0.is_empty()
    }

    pub fn contains(&self, x: &T) -> bool {
        if !self.is_empty() {
            self.0.contains(x)
        } else {
            false
        }
    }

    pub fn is_subset(&self, other: &Self) -> bool {
        self.is_empty() || other.0.windows(self.len()).any(|window| {
            self.0.iter().zip(window).all(|(x, y)| x == y)
        })
    }

    pub fn is_disjoint(&self, other: &Self) -> bool {
        !self.0.iter().any(|e| other.contains(e))
    }

    pub fn add(&mut self, x: T) {
        if !self.contains(&x) {
            self.0.push(x)
        }
    }

    pub fn len(&self) -> usize {
        self.0.len()
    }

    pub fn intersection(&self, other: &Self) -> Self {
        self.0.iter()
            .filter(|&e| other.contains(e))
            .cloned()
            .collect()
    }

    pub fn difference(&self, other: &Self) -> Self {
        self.0.iter()
            .filter(|&e| !other.contains(e))
            .cloned()
            .collect()
    }

    pub fn union(&self, other: &Self) -> Self {
        self.0.iter().chain(other.0.iter()).cloned().collect()
    }
}
