defmodule Prime do
  @doc """
  Generates the nth prime.
  """
  @spec nth(non_neg_integer) :: non_neg_integer
  def nth(count) when count < 1, do: raise "argument should greather than 0"
  def nth(1), do: 2

  def nth(count) do
    Stream.iterate(3, &(&1 + 1))
    |> Stream.take_every(2)
    |> Stream.filter(&is_prime?/1)
    |> Enum.take(count - 1)
    |> List.last()
  end

  def is_prime?(0), do: false
  def is_prime?(number) when number in [2, 3], do: true

  def is_prime?(number) do
    Stream.iterate(2, &(&1 + 1))
    |> Stream.take_while(&(&1 <= Integer.floor_div(number, 2)))
    |> Enum.any?(fn x -> rem(number, x) == 0 end)
    |> Kernel.not()
  end
end
