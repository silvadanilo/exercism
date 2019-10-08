defmodule Tournament do
  @doc """
  Given `input` lines representing two teams and whether the first of them won,
  lost, or reached a draw, separated by semicolons, calculate the statistics
  for each team's number of games played, won, drawn, lost, and total points
  for the season, and return a nicely-formatted string table.

  A win earns a team 3 points, a draw earns 1 point, and a loss earns nothing.

  Order the outcome by most total points for the season, and settle ties by
  listing the teams in alphabetical order.
  """
  @spec tally(input :: list(String.t())) :: String.t()
  def tally(input) do
    input
    |> collect_stats()
    |> to_table()
  end

  defp to_table(stats) do
    stats
    |> List.insert_at(0,{"Team", %{mp: "MP", w: "W", d: "D", l: "L", p: "P"}})
    |> Enum.map(&format_row/1)
    |> Enum.join("\n")
  end

  defp format_row({team, stats}) do
    [
      String.pad_trailing(team, 30),
      format_int(stats[:mp]),
      format_int(stats[:w]),
      format_int(stats[:d]),
      format_int(stats[:l]),
      format_int(stats[:p])
    ]
    |> Enum.join(" | ")
  end

  defp format_int(int) do
    String.pad_leading("#{int}", 2)
  end

  defp collect_stats(input) do
    input
    |> Enum.flat_map(&parse_stats/1)
    |> Enum.reduce(Map.new(), &collect_stats/2)
    |> Enum.sort_by(fn {_, stats} -> stats[:p] end, &Kernel.>=/2)
  end

  defp collect_stats({team, stat}, acc) do
    Map.update(acc, team, stat, fn current_stats ->
      current_stats
      |> Map.update(:w, 0, fn current_wins -> current_wins + stat[:w] end)
      |> Map.update(:l, 0, fn current_loss -> current_loss + stat[:l] end)
      |> Map.update(:mp, 0, fn current_mp -> current_mp + stat[:mp] end)
      |> Map.update(:p, 0, fn current_p -> current_p + stat[:p] end)
      |> Map.update(:d, 0, fn current_d -> current_d + stat[:d] end)
    end)
  end

  defp parse_stats(line) when is_binary(line) do
    line
    |> String.split(";")
    |> parse_stats()
  end

  defp parse_stats([winner, loser, "win"]) do
    [
      {winner, stats(%{w: 1, p: 3})},
      {loser, stats(%{l: 1})}
    ]
  end

  defp parse_stats([loser, winner, "loss"]) do
    [
      {winner, stats(%{w: 1, p: 3})},
      {loser, stats(%{l: 1})}
    ]
  end

  defp parse_stats([teamA, teamB, "draw"]) do
    [
      {teamA, stats(%{d: 1, p: 1})},
      {teamB, stats(%{d: 1, p: 1})}
    ]
  end

  defp parse_stats(_) do
    []
  end

  defp stats(overwrite) do
    Map.merge(%{mp: 1, w: 0, d: 0, l: 0, p: 0}, overwrite)
  end
end
