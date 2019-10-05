const FRAMES: usize = 10;

#[derive(Clone, Debug, PartialEq)]
enum Frame {
    Strike(Option<u8>, Option<u8>),
    Spare(Option<u8>),
    Standard(Option<u8>, Option<u8>),
    Available,
}

impl Frame {
    pub fn roll(&mut self, p: u8) -> Result<Frame, ()> {
        use Frame::*;
        if p > 10 {
            return Err(());
        };

        let next: Frame = match *self {
            Available => {
                match p {
                    10 => Strike(None, None),
                    _ => Standard(Some(p), None),
                }
            }
            Standard(Some(first), None) => {
                match first + p {
                    x if x > 10 => {
                        return Err(());
                    }
                    10 => Spare(None),
                    _ => Standard(Some(first), Some(p)),
                }
            }
            Spare(None) => Spare(Some(p)),
            Strike(None, None) => Strike(Some(p), None),
            Strike(Some(x), None) => {
                if x != 10 && x + p > 10 {
                    return Err(());
                };
                Strike(Some(x), Some(p))
            }
            _ => self.clone(),
        };

        Ok(next)
    }

    pub fn score(&self) -> u8 {
        use Frame::*;
        match *self {
            Standard(Some(a), Some(b)) => a + b,
            Spare(Some(a)) => 10 + a,
            Strike(Some(a), Some(b)) => 10 + a + b,
            _ => 0,
        }
    }

    pub fn is_completed(&self) -> bool {
        use Frame::*;
        match *self {
            Standard(Some(_), Some(_)) => true,
            Spare(Some(_)) => true,
            Strike(Some(_), Some(_)) => true,
            _ => false,
        }
    }

    pub fn frame_rolls_are_completed(&self) -> bool {
        use Frame::*;
        match *self {
            Available => false,
            Standard(Some(_), None) => false,
            _ => true,
        }
    }
}

pub struct BowlingGame {
    frames: Vec<Frame>,
}

impl BowlingGame {
    pub fn new() -> Self {
        let mut game = BowlingGame { frames: Vec::with_capacity(FRAMES) };
        game.frames.push(Frame::Available);
        game
    }

    pub fn roll(&mut self, point: u8) -> Result<(), ()> {
        if self.is_done() {
            return Err(());
        }

        for mut frame in self.frames.iter_mut() {
            *frame = try!(frame.roll(point));
        }

        if self.frames.len() < FRAMES && self.frames.last().unwrap().frame_rolls_are_completed() {
            self.frames.push(Frame::Available);
        }

        Ok(())
    }

    pub fn score(&self) -> Result<u16, ()> {
        if !self.is_done() {
            return Err(());
        }

        Ok(self.frames.iter().map(|f| f.score() as u16).sum())
    }

    fn is_done(&self) -> bool {
        self.frames.iter().all(|f| f.is_completed())
    }
}
