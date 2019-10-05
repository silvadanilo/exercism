#![feature(test)]
extern crate test;

pub struct PascalsTriangle(u32);
impl PascalsTriangle {
    pub fn new(row_count: u32) -> Self {
        PascalsTriangle(row_count)
    }
    pub fn rows(&self) -> Vec<Vec<u32>> {
        let mut res = Vec::<Vec<u32>>::with_capacity(self.0 as usize);
        for row in 0..self.0 {
            let mut row_vec = Vec::<u32>::with_capacity(row as usize + 1);
            row_vec.push(1);
            let mut num = 1;
            for pos in 1..row + 1 {
                num = (num * (row + 1 - pos)) / pos;
                row_vec.push(num);
            }
            res.push(row_vec);
        }
        res
    }
}

pub struct PascalsTriangle2(u32);
impl PascalsTriangle2 {
    pub fn new(row_count: u32) -> Self {
        PascalsTriangle2(row_count)
    }
    pub fn rows(&self) -> Vec<Vec<u32>> {
        (0..self.0).map(|row| {
            (1..row+2).fold((Vec::<u32>::with_capacity((row+1) as usize),1),|(mut rvec,num),pos|{
                rvec.push(num);
                (rvec, (num * (row + 1 - pos)) / pos)
            }).0
        }).collect()
    }
}

pub struct PascalsTriangle3(u32);

impl PascalsTriangle3 {
    pub fn new(row_count: u32) -> Self {
        PascalsTriangle3(row_count)
    }

    pub fn rows(&self) -> Vec<Vec<u32>> {
        fn f(n: u32)         -> u32 { (1..).take_while(|&i| i <= n).product() }
        fn c(n: u32, m: u32) -> u32 { f(n) / (f(m) * f(n-m)) }

        (0..self.0).map( |i| (0..i+1).map( |j| c(i, j) ).collect()).collect()
    }
}

pub struct PascalsTriangle4 {
    row_count: u32
}

impl PascalsTriangle4 {
    pub fn new(row_count: u32) -> Self {
        PascalsTriangle4 {
            row_count: row_count
        }
    }

    pub fn rows(&self) -> Vec<Vec<u32>> {
        PascalsTriangle4::recursive(self.row_count)
    }

    fn recursive(row: u32) -> Vec<Vec<u32>> {
        match row {
            0 => vec![],
            1 => vec![vec![1]],
            _ => {
                let mut partial = Vec::<u32>::with_capacity(row as usize);
                let mut result = PascalsTriangle4::recursive(row -1);
                {
                    let last_row = &result[result.len() - 1];
                    let mut last_value: u32 = 0;
                    for i in last_row {
                        partial.push(last_value + i);
                        last_value = *i;
                    }
                    partial.push(1);
                }

                result.push(partial);
                result
            }
        }

    }
}

pub struct PascalsTriangle5 {
    row_count: u32
}

impl PascalsTriangle5 {
    pub fn new(row_count: u32) -> Self {
        PascalsTriangle5 {
            row_count: row_count
        }
    }

    pub fn rows(&self) -> Vec<Vec<u32>> {
        PascalsTriangle5::recursive(self.row_count)
    }

    fn recursive(row: u32) -> Vec<Vec<u32>> {
        match row {
            0 => vec![],
            1 => vec![vec![1]],
            _ => {
                let mut partial = Vec::<u32>::with_capacity(row as usize);
                let mut result = PascalsTriangle5::recursive(row -1);
                {
                    let last_row = &result[result.len() - 1];
                    for i in std::iter::once(1)
                        .chain(last_row.windows(2).map(|w| w.iter().sum()))
                        .chain(std::iter::once(1)) {
                        partial.push(i)
                    }
                }

                result.push(partial);
                result
            }
        }

    }
}
#[cfg(test)]
mod tests {
    use super::*;
    use test::Bencher;

    #[bench]
    fn PascalsTriangle_887(b: &mut Bencher) {
        let p = PascalsTriangle::new(10);
        b.iter(|| p.rows());
    }
    #[bench]
    fn PascalsTriangle_887_fn(b: &mut Bencher) {
        let p = PascalsTriangle2::new(10);
        b.iter(|| p.rows());
    }
    #[bench]
    fn PascalsTriangle_zenspider(b: &mut Bencher) {
        let p = PascalsTriangle3::new(10);
        b.iter(|| p.rows());
    }
    #[bench]
    fn PascalsTriangle_danilo(b: &mut Bencher) {
        let p = PascalsTriangle4::new(10);
        b.iter(|| p.rows());
    }
    #[bench]
    fn PascalsTriangle_danilo2(b: &mut Bencher) {
        let p = PascalsTriangle5::new(10);
        b.iter(|| p.rows());
    }
}
