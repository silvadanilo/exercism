defmodule Darts do
  @type position :: {number, number}

  @scores [{1, 10}, {5, 5}, {10, 1}]

  @doc """
  Calculate the score of a single dart hitting a target
  """
  @spec score(position) :: integer
  def score({x, y}) do
    distance_from_center = :math.sqrt(x ** 2 + y ** 2)

    @scores
    |> Enum.find(fn {radius, _score} -> distance_from_center <= radius end)
    |> case do
      nil -> 0
      {_, score} -> score
    end
  end

  ## Alternative solutions
  # def score({x, y}), do: do_score(:math.sqrt(x ** 2 + y ** 2))
  #
  # defp do_score(distance) when distance <= 1, do: 10
  # defp do_score(distance) when distance <= 5, do: 5
  # defp do_score(distance) when distance <= 10, do: 1
  # defp do_score(_distance), do: 0
end
