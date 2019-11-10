defmodule Minesweeper do
  @mine "*"
  @empty " "

  @doc """
  Annotate empty spots next to mines with the number of mines next to them.
  """
  @spec annotate([String.t()]) :: [String.t()]
  def annotate(board) do
    output =
      board
      |> Enum.map(&(String.split(&1, "", trim: true)))

    output
    |> Enum.with_index()
    |> Enum.map(&(process_row(&1, output)))
    |> Enum.map(&Enum.join/1)
  end

  defp process_row({cols, x}, board) do
    cols
    |> Enum.with_index()
    |> Enum.map(&(process_cell(&1, x, board)))
  end

  defp process_cell({@mine, _y}, _x, _board), do: @mine

  defp process_cell({@empty, y}, x, board) do
    for x <- x-1..x+1, y <- y-1..y+1, into: [] do
      count(board, x, y)
    end
    |> Enum.sum()
    |> case do
      0 -> @empty
      n -> n
    end
  end

  defp count(_board, x, y) when x < 0 or y < 0, do: 0
  defp count(board, x, y), do: count(Enum.at(board, x), y)
  defp count(nil, _y), do: 0
  defp count(cols, y), do: count(Enum.at(cols, y))

  defp count(@mine), do: 1
  defp count(_), do: 0
end
