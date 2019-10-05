use std::cmp::Ordering;
use std::collections::HashMap;
use std::fmt::Display;
use std::str::FromStr;


#[derive(Debug)]
struct InvalidValue;

#[derive(Debug)]
enum Outcome {
    Win,
    Loss,
    Draw,
}

impl FromStr for Outcome {
    type Err = InvalidValue;
    fn from_str(s: &str) -> Result<Self, Self::Err> {
        match s {
            "win" => Ok(Outcome::Win),
            "loss" => Ok(Outcome::Loss),
            "draw" => Ok(Outcome::Draw),
            _ => Err(InvalidValue),
        }
    }
}

#[derive(Debug)]
struct PlayedMatch {
    home_name: String,
    visitor_name: String,
    outcome: Outcome,
}

impl FromStr for PlayedMatch {
    type Err = InvalidValue;
    fn from_str(s: &str) -> Result<Self, Self::Err> {
        let splitted: Vec<&str> = s.split(';').collect();
        if 3 != splitted.len() {
            return Err(InvalidValue);
        }

        let outcome = try!(splitted[2].parse());
        Ok(PlayedMatch {
            home_name: splitted[0].to_string(),
            visitor_name: splitted[1].to_string(),
            outcome: outcome,
        })
    }
}

impl PlayedMatch {
    pub fn process(&self, league: &mut HashMap<String, Team>) {
        match self.outcome {
            Outcome::Win => {
                Team::from_league(self.home_name.clone(), league).win();
                Team::from_league(self.visitor_name.clone(), league).loss();
            }
            Outcome::Loss => {
                Team::from_league(self.home_name.clone(), league).loss();
                Team::from_league(self.visitor_name.clone(), league).win();
            }
            Outcome::Draw => {
                Team::from_league(self.home_name.clone(), league).draw();
                Team::from_league(self.visitor_name.clone(), league).draw();
            }
        }
    }
}

#[derive(Default, Debug, Eq, PartialEq, PartialOrd)]
struct Team {
    name: String,
    match_played: u8,
    wins: u8,
    draws: u8,
    losses: u8,
    points: u8,
}

impl Team {
    pub fn from_league(name: String, league: &mut HashMap<String, Team>) -> &mut Self {
        league.entry(name.clone())
            .or_insert(Team::new(name.clone()))
    }

    pub fn new(name: String) -> Self {
        Team {
            name: name,
            match_played: 0,
            wins: 0,
            draws: 0,
            losses: 0,
            points: 0,
        }
    }

    pub fn win(&mut self) {
        self.match_played += 1;
        self.wins += 1;
        self.points += 3;
    }

    pub fn loss(&mut self) {
        self.match_played += 1;
        self.losses += 1;
    }

    pub fn draw(&mut self) {
        self.match_played += 1;
        self.draws += 1;
        self.points += 1;
    }
}

impl Ord for Team {
    fn cmp(&self, other: &Team) -> Ordering {
        match other.points.cmp(&self.points) {
            Ordering::Equal => self.name.cmp(&other.name),
            order => order,
        }
    }
}

pub fn tally(played_matches: &String) -> String {
    let mut league: HashMap<String, Team> = HashMap::new();

    for played_match in played_matches.lines() {
        if let Ok(played_match) = played_match.parse::<PlayedMatch>() {
            played_match.process(&mut league);
        }
    }

    Ranking::new(league.values().collect()).display()
}

struct Ranking<'a> {
    teams: Vec<&'a Team>,
}

impl<'a> Ranking<'a> {
    pub fn new(teams: Vec<&'a Team>) -> Self {
        Ranking { teams: teams }
    }

    pub fn display(&mut self) -> String {
        self.teams.sort();

        let mut output = vec![self.format_row(&["Team", "MP", "W", "D", "L", "P"])];

        output.append(&mut self.teams
            .iter()
            .map(|ref team| self.format_team(team))
            .collect::<Vec<String>>());

        output.join("\n")
    }

    fn format_team(&self, team: &Team) -> String {
        self.format_row(&[team.name.to_string(),
                           team.match_played.to_string(),
                           team.wins.to_string(),
                           team.draws.to_string(),
                           team.losses.to_string(),
                           team.points.to_string()])
    }

    fn format_row<T: Display>(&self, data: &[T]) -> String {
        format!("{0:<30} | {1:>2} | {2:>2} | {3:>2} | {4:>2} | {5:>2}",
                data[0], data[1], data[2], data[3], data[4], data[5])
    }
}
