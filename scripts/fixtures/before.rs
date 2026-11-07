use std::collections::HashMap;

/// Count word frequencies in a text.
fn count_words(text: &str) -> HashMap<String, usize> {
    let mut counts = HashMap::new();
    for word in text.split_whitespace() {
        *counts.entry(word.to_string()).or_insert(0) += 1;
    }
    counts
}

fn main() {
    let counts = count_words("the great wave off kanagawa");
    println!("{:?}", counts);
}
