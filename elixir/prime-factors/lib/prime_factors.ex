defmodule PrimeFactors do
  @doc """
  Compute the prime factors for 'number'.

  The prime factors are prime numbers that when multiplied give the desired
  number.

  The prime factors of 'number' will be ordered lowest to highest.
  """
  @spec factors_for(pos_integer) :: [pos_integer]
  def factors_for(number), do: factors_for(number, [])

  # if number is even divide it by 2 until it becames odd
  def factors_for(number, factors) when rem(number, 2) == 0 do
    factors_for(div(number, 2), [2 | factors])
  end

  # now the number is necessarily odd
  def factors_for(number, factors) do
    # start a loop from 3 to the square root of number
    factors_for(number, 3, factors)
  end

  defp factors_for(number, maybe_factor, factors) do
    cond do
      # when number == 1 the search is finished
      number == 1 ->
        factors

      # end the loop at the square root of `number`
      # If a number N has a prime factor larger than sqrt(N), then it surely has a prime factor smaller than sqrt(N).
      # If no prime factors exist in the range [1,sqrt(n)], then N itself is prime and there is no need to continue searching beyond that range
      maybe_factor > :math.sqrt(number) ->
        factors ++ [number]

      # when maybe_factor is a factor of number add it to the list and check it again
      rem(number, maybe_factor) == 0 ->
        factors_for(div(number, maybe_factor), maybe_factor, factors ++ [maybe_factor])

      # iterate through odd numbers
      true ->
        factors_for(number, maybe_factor + 2, factors)
    end
  end
end
