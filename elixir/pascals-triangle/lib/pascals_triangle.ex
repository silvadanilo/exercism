defmodule PascalsTriangle do
  @doc """
  Calculates the rows of a pascal triangle
  with the given height
  """
  @spec rows(integer) :: [[integer]]
  def rows(num) do
    Stream.iterate([1], fn previous ->
      [1 | previous |> Enum.chunk_every(2, 1) |> Enum.map(&Enum.sum/1)]
    end)
    |> Enum.take(num)
  end
end
