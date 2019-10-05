extern crate chrono;
use chrono::*;

const GIGASECONDS: i64 = 1000000000;

pub fn after(start: DateTime<UTC>) -> DateTime<UTC> {
    start + Duration::seconds(GIGASECONDS)
}
