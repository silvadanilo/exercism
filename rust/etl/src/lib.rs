use std::collections::BTreeMap;

pub fn transform(old_scores_map: &BTreeMap<i32, Vec<String>>) -> BTreeMap<String, i32> {
    let new_scores_map: BTreeMap<String, i32> = BTreeMap::new();

    old_scores_map.iter().fold(new_scores_map, |scores_map, (score, letters)| {
        letters.iter().map(|c| c.to_lowercase()).fold(scores_map, |mut scores_map, c| {
            scores_map.insert(c, *score);
            scores_map
        })
    })
}
