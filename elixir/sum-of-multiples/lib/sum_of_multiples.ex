defmodule SumOfMultiples do
  @doc """
  Adds up all numbers from 1 to a given end number that are multiples of the factors provided.
  """
  @spec to(non_neg_integer, [non_neg_integer]) :: non_neg_integer
  def to(limit, factors) do
    1..limit-1
    |> take_only_divisible_by_factors(factors)
    |> Enum.sum()
  end

  defp take_only_divisible_by_factors(numbers, factors) do
    numbers
    |> Enum.filter(&(is_factors(factors, &1)))
  end

  defp is_factors(factors, number) do
    factors
    |> Enum.any?(&(rem(number, &1) === 0))
  end
end
