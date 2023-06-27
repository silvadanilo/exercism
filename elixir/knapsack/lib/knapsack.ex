defmodule Knapsack do
  @doc """
  Return the maximum value that a knapsack can carry.
  """
  @spec maximum_value(items :: [%{value: integer, weight: integer}], maximum_weight :: integer) ::
          integer
  def maximum_value([], _maximum_weight), do: 0
  def maximum_value([h | _t], maximum_weight) when h.weight > maximum_weight, do: 0

  def maximum_value([h | t], maximum_weight) do
    Enum.max([
      h.value + maximum_value(t, maximum_weight - h.weight),
      maximum_value(t, maximum_weight)
    ])
  end
end
