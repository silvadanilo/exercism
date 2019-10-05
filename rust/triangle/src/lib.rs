extern crate num;

use num::Num;
use num::zero;

pub struct Triangle<T> {
    sides: [T; 3],
}

impl<T: Num + PartialOrd + Copy> Triangle<T> {
    pub fn build(sides: [T; 3]) -> Result<Triangle<T>, String> {

        let t = Triangle { sides: sides };
        match t.has_valid_sides() {
            Err(x @ _) => return Err(x),
            Ok(_) => Ok(t)
        }
    }

    fn has_valid_sides(&self) -> Result<(), String> {
        let z = zero();
        if self.sides.iter().any(|&s| s <= z) {
            return Err("side must be greather than `0`".into());
        }

        if  self.sides[0] + self.sides[1] <= self.sides[2] ||
            self.sides[0] + self.sides[2] <= self.sides[1] ||
            self.sides[1] + self.sides[2] <= self.sides[0] {
                return Err("sum of two sides must equal or exceed the remaining side one".into());
        }

        Ok(())
    }

    pub fn is_equilateral(&self) -> bool {
        self.sides[0] == self.sides[1] && self.sides[0] == self.sides[2]
    }

    pub fn is_isosceles(&self) -> bool {
        !self.is_equilateral() && (
            self.sides[0] == self.sides[1] ||
            self.sides[0] == self.sides[2] ||
            self.sides[1] == self.sides[2]
        )
    }

    pub fn is_scalene(&self) -> bool {
        self.sides[0] != self.sides[1] &&
        self.sides[0] != self.sides[2] &&
        self.sides[1] != self.sides[2]
    }
}
