HEADER = [f"{'Team':31}| MP |  W |  D |  L |  P"]
RESULT_MAP = {"win": "loss", "loss": "win", "draw": "draw"}


def tally(rows):
    return Tournament(rows).table()


class Team:
    def __init__(self, name):
        self.name = name
        self.games = {"win": 0, "draw": 0, "loss": 0}

    def add_result(self, result):
        self.games.update({result: self.games[result] + 1})

    def points(self):
        return self.games["draw"] + (3 * self.games["win"])

    def matches(self):
        return self.games["win"] + self.games["draw"] + self.games["loss"]

    def __str__(self):
        games = self.games
        return f"{self.name:<31}|{self.matches():>3} |{games['win']:>3} |{games['draw']:>3} |{games['loss']:>3} |{self.points():>3}"


class Tournament:
    def __init__(self, rows):
        self.tally = {}
        for row in rows:
            team_a, team_b, result = row.split(";")
            self.tally.setdefault(team_a, Team(team_a)).add_result(result)
            self.tally.setdefault(team_b, Team(team_b)).add_result(RESULT_MAP[result])

    def table(self):
        return HEADER + [
            str(team)
            for team in sorted(
                self.tally.values(),
                key=lambda team: (-team.points(), team.name),
                reverse=False,
            )
        ]
