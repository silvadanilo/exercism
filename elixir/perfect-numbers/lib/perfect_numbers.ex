defmodule PerfectNumbers do
  @doc """
  Determine the aliquot sum of the given `number`, by summing all the factors
  of `number`, aside from `number` itself.

  Based on this sum, classify the number as:

  :perfect if the aliquot sum is equal to `number`
  :abundant if the aliquot sum is greater than `number`
  :deficient if the aliquot sum is less than `number`
  """
  @spec classify(number :: integer) :: {:ok, atom} | {:error, String.t()}
  def classify(number) when number < 1,
    do: {:error, "Classification is only possible for natural numbers."}

  def classify(number) do
    number
    |> divisors()
    |> Enum.sum()
    |> case do
      ^number -> {:ok, :perfect}
      n when n > number -> {:ok, :abundant}
      n when n < number -> {:ok, :deficient}
    end
  end

  defp divisors(1), do: []
  defp divisors(n), do: [1 | divisors(2, n, :math.sqrt(n))] |> Enum.sort()

  defp divisors(k, _n, q) when k > q, do: []
  defp divisors(k, n, q) when rem(n, k) > 0, do: divisors(k + 1, n, q)
  defp divisors(k, n, q) when k * k == n, do: [k | divisors(k + 1, n, q)]
  defp divisors(k, n, q), do: [k, div(n, k) | divisors(k + 1, n, q)]
end
