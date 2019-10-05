#![feature(test)]
extern crate test;

pub fn hamming_distance_zip(strands1: &str, strands2: &str) -> Result<u32, &'static str> {
    if strands1.len() != strands2.len() {
        return Err("sequences must have the same length");
    }

    // //#ZIP way
    let distance: u32 = strands1.chars()
        .zip(strands2.chars())
        .fold(0, |acc, (strands1_char, strands2_char)| {
              if strands1_char != strands2_char {
                  acc + 1
              } else {
                  acc
              }
        });

    Ok(distance)
}

pub fn hamming_distance_for(strands1: &str, strands2: &str) -> Result<u32, &'static str> {
    if strands1.len() != strands2.len() {
        return Err("sequences must have the same length");
    }

    let mut distance: u32 = 0;

    let chars2 = strands2.chars().collect::<Vec<_>>();
    for (i, c) in strands1.chars().enumerate() {
        if c != chars2[i] {
            distance += 1;
        }
    }

    Ok(distance)
}

#[cfg(test)]
mod tests {
    use super::*;
    use test::Bencher;

    #[bench]
    fn hamming_zip(b: &mut Bencher) {
        b.iter(|| hamming_distance_zip(
            "DASFAEQWQEKDHASDKDSAKNVJSASHJSAJJASJDSA",
            "DASFKJFVNDKASJDSAEIDHASDHASHDSAJJASJDSA"
        ));
    }

    #[bench]
    fn hamming_for(b: &mut Bencher) {
        b.iter(|| hamming_distance_for(
            "DASFAEQWQEKDHASDKDSAKNVJSASHJSAJJASJDSA",
            "DASFKJFVNDKASJDSAEIDHASDHASHDSAJJASJDSA"
        ));
    }
}

