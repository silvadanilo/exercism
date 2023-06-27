defmodule KillerSudokuHelper do
  @doc """
  Return the possible combinations of `size` distinct numbers from 1-9 excluding `exclude` that sum up to `sum`.
  """
  @spec combinations(cage :: %{exclude: [integer], size: integer, sum: integer}) :: [[integer]]

  def combinations(%{size: size, exclude: exclude, sum: sum}) do
    1..9
    |> Enum.reject(fn x -> x in exclude or x > sum end)
    |> Combinations.generate_combinations(size)
    |> Enum.filter(fn possible_solution -> Enum.sum(possible_solution) == sum end)
  end
end

defmodule Combinations do
  def generate_combinations(_, 0), do: [[]]
  def generate_combinations([], _), do: []

  def generate_combinations([h | t], k) do
    for(x <- generate_combinations(t, k - 1), do: [h | x]) ++ generate_combinations(t, k)
  end
end
