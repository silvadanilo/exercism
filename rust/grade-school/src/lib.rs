use std::collections::BTreeMap;

#[derive(Default)]
pub struct School {
    students: BTreeMap<u8, Vec<String>>,
}

impl School {
    pub fn new() -> School {
        School::default()
    }

    pub fn add(&mut self, grade: u8, name: &str) -> () {
        let name = name.to_string();
        let names = self.students.entry(grade).or_insert(Vec::new());
        let i = names.binary_search(&name).unwrap_or_else(|i| i);
        names.insert(i, name);
    }

    pub fn grades(&self) -> Vec<u8> {
        self.students.keys().cloned().collect()
    }

    pub fn grade(&self, grade: u8) -> Option<&Vec<String>> {
        self.students.get(&grade)
    }
}
