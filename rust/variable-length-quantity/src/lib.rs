static VALUE_MASK: u8 = 0b01111111;
static INTERMEDIATE: u8 = 0b10000000;

pub fn to_bytes(values: &[u32]) -> Vec<u8> {
    let mut res: Vec<u8> = Vec::with_capacity(4);

    for value in values {
        res.append(&mut single_byte(*value));
    }

    res
}

fn single_byte(mut value: u32) -> Vec<u8> {
    if value == 0 {
        return vec![0];
    }

    let mut res: Vec<u8> = Vec::with_capacity(4);
    while value > 0 {
        let mut partial = (value & VALUE_MASK as u32) as u8;
        value = value >> 7u32;

        if !res.is_empty() {
            partial |= INTERMEDIATE;
        }

        res.push(partial);
    }

    res.reverse();
    res
}

pub fn from_bytes(bytes: &[u8]) -> Result<Vec<u32>, &'static str> {
    let mut res = Vec::new();
    let mut partial = 0;

    for b in bytes.iter() {
        if partial >= (1 << 25) {
            return Err("number is too large to fit in u32");
        }

        partial = (partial << 7) | (b & VALUE_MASK) as u32;

        if (b & INTERMEDIATE) == 0 {
            res.push(partial);
            partial = 0;
        }
    }

    if partial != 0 || res.is_empty() {
        Err("Incomplete")
    } else {
        Ok(res)
    }
}
