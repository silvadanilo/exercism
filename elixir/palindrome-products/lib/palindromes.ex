defmodule Palindromes do
  @doc """
  Generates all palindrome products from an optionally given min factor (or 1) to a given max factor.
  """
  @spec generate(non_neg_integer, non_neg_integer) :: map
  def generate(max_factor, min_factor \\ 1) do
    for x <- min_factor..max_factor,
        y <- min_factor..max_factor,
        x <= y,
        is_palindrome(Integer.digits(x * y)) do
      {x * y, [x, y]}
    end
    |> Enum.reduce(%{}, &compess_duplicates/2)
  end

  defp is_palindrome(digits) do
    digits == Enum.reverse(digits)
  end

  defp compess_duplicates({palindrome, from}, acc) do
    acc
    |> Map.update(palindrome, [from], fn current -> [from | current] end)
  end
end
