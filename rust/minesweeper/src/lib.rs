use std::char;
use std::cmp;

pub fn annotate(input_board: &Vec<&str>) -> Vec<String> {

    let mut board: Vec<Vec<char>> = input_board.iter()
        .map(|r| r.chars().collect())
        .collect();

    let max_rows = board.len();
    let max_cols = board[0].len();

    for (row_number, row) in input_board.iter().enumerate() {
        for (col_number, c) in row.chars().enumerate() {
            if c == '*' {
                let ((from_x, to_x), (from_y, to_y)) =
                    ((row_number.checked_sub(1).unwrap_or(0), cmp::min(row_number + 2, max_rows)),
                     (col_number.checked_sub(1).unwrap_or(0), cmp::min(col_number + 2, max_cols)));

                for x in from_x..to_x {
                    for y in from_y..to_y {
                        if board[x][y] == '*' {
                            continue;
                        };

                        board[x][y] = char::from_digit(board[x][y].to_digit(10).unwrap_or(0) + 1, 10).unwrap();
                    }
                }
            }
        }
    }

    board.iter().map(|r| r.into_iter().map(|c| *c).collect::<String>()).collect()
}
