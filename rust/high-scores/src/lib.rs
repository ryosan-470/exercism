#[derive(Debug)]
pub struct HighScores {
    scores: Vec<u32>,
}

impl HighScores {
    pub fn new(scores: &[u32]) -> Self {
        HighScores {
            scores: Vec::from(scores),
        }
    }

    pub fn scores(&self) -> &[u32] {
        self.scores.as_slice()
    }

    pub fn latest(&self) -> Option<u32> {
        self.scores.iter().cloned().last()
    }

    pub fn personal_best(&self) -> Option<u32> {
        self.scores.iter().cloned().max()
    }

    pub fn personal_top_three(&self) -> Vec<u32> {
        let mut sorted: Vec<u32> = self.scores.clone();
        sorted.sort();

        if sorted.len() <= 3 {
            sorted.iter().rev().cloned().collect()
        } else {
            sorted
                .split_off(sorted.len() - 3)
                .iter()
                .rev()
                .cloned()
                .collect()
        }
    }
}
