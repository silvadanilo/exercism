#![feature(inclusive_range_syntax)]
#![feature(range_contains)]

pub struct ChessPosition {
    x: i8,
    y: i8,
}

impl ChessPosition {
    pub fn new(x: i8, y: i8) -> Result<ChessPosition, &'static str> {
        if [x, y].iter().any(|&p| !(0...7).contains(p)) {
            Err("Invalid Position")
        } else {
            Ok(ChessPosition { x: x, y: y })
        }
    }

    pub fn is_on_the_same_row(&self, p: &ChessPosition) -> bool {
        self.x == p.x
    }

    pub fn is_on_the_same_column(&self, p: &ChessPosition) -> bool {
        self.y == p.y
    }

    pub fn is_on_the_same_diagonal(&self, p: &ChessPosition) -> bool {
        (self.x - p.x).abs() == (self.y - p.y).abs()
    }
}

pub struct Queen {
    position: ChessPosition,
}

impl Queen {
    pub fn new(p: ChessPosition) -> Queen {
        Queen { position: p }
    }

    pub fn can_attack(&self, piece: &Queen) -> bool {
        self.position.x == piece.position.x || self.position.y == piece.position.y ||
        (self.position.x - piece.position.x).abs() == (self.position.y - piece.position.y).abs()
    }
}
