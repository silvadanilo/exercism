// The code below is a stub. Just enough to satisfy the compiler.
// In order to pass the tests you can add-to or change any of this code.
#![allow(unused_variables)]

pub struct Duration(f64);

impl From<u64> for Duration {
    fn from(s: u64) -> Self {
        Duration(s as f64)
    }
}

pub trait Planet {
    fn years_during(d: &Duration) -> f64 {
        d.0 / Self::seconds_in_year()
    }

    fn seconds_in_year() -> f64;
}

macro_rules! impl_planet {
    ($a:ident,$b:expr) => {
        pub struct $a;
        impl Planet for $a {
            fn seconds_in_year() -> f64 {
                Earth::seconds_in_year() * $b
            }
        }
    }
}

impl_planet!(Neptune, 164.79132f64);
impl_planet!(Uranus, 84.016846f64);
impl_planet!(Saturn, 29.447498f64);
impl_planet!(Jupiter, 11.862615f64);
impl_planet!(Mars, 1.8808158f64);
impl_planet!(Venus, 0.61519726f64);
impl_planet!(Mercury, 0.2408467f64);

pub struct Earth;
impl Planet for Earth {
    fn seconds_in_year() -> f64 {
        31557600f64
    }
}
