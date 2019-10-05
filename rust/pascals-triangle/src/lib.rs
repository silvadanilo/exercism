pub struct PascalsTriangle {
    row_count: u32
}

impl PascalsTriangle {
    pub fn new(row_count: u32) -> Self {
        PascalsTriangle {
            row_count: row_count
        }
    }

    pub fn rows(&self) -> Vec<Vec<u32>> {
        PascalsTriangle::recursive(self.row_count)
    }

    fn recursive(row: u32) -> Vec<Vec<u32>> {
        match row {
            0 => vec![],
            1 => vec![vec![1]],
            _ => {
                let mut partial = Vec::<u32>::with_capacity(row as usize);
                let mut result = PascalsTriangle::recursive(row -1);
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
