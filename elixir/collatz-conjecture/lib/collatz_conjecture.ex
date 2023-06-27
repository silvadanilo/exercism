defmodule CollatzConjecture do
  defguardp is_pos_integer(number) when is_integer(number) and number > 0
  defguardp is_even(number) when rem(number, 2) == 0

  @doc """
  calc/1 takes an integer and returns the number of steps required to get the
  number to 1 when following the rules:
    - if number is odd, multiply with 3 and add 1
    - if number is even, divide by 2
  """
  @spec calc(input :: pos_integer()) :: non_neg_integer()
  def calc(input) when is_pos_integer(input), do: do_calc(input, 0)

  defp do_calc(1, acc), do: acc
  defp do_calc(input, acc) when is_even(input), do: do_calc(div(input, 2), acc + 1)
  defp do_calc(input, acc), do: do_calc(input * 3 + 1, acc + 1)
end
