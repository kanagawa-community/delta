use std::collections::BTreeMap;

/// Count word frequencies in a text, ignoring case.
fn count_words(text: &str) -> BTreeMap<String, usize> {
    let mut counts = BTreeMap::new();
    for word in text.split_whitespace() {
        *counts.entry(word.to_lowercase()).or_insert(0) += 1;
    }
    counts
}

fn main() {
    let counts = count_words("The Great Wave off Kanagawa");
    for (word, n) in &counts {
        println!("{word}: {n}");
    }
}
