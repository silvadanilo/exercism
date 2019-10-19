defmodule AllYourBase do
  @doc """
  Given a number in base a, represented as a sequence of digits, converts it to base b,
  or returns nil if either of the bases are less than 2
  """

  @spec convert(list, integer, integer) :: list
  def convert(digits, base_a, base_b)
      when digits === []
      when base_a < 2
      when base_b < 2,
      do: nil

  def convert(digits, base_a, base_b) do
    cond do
      invalid?(digits, base_a) ->
        nil

      true ->
        digits
        |> number(base_a)
        |> to_base(base_b)
    end
  end

  defp number(digits, base) do
    digits
    |> Enum.reverse()
    |> Enum.with_index()
    |> Enum.map(fn {digit, index} -> Kernel.trunc(digit * :math.pow(base, index)) end)
    |> Enum.sum()
  end

  defp to_base(number, base, acc \\ [])
  defp to_base(0, _, []), do: [0]
  defp to_base(0, _, acc), do: acc

  defp to_base(number, base, acc) do
    acc = [rem(number, base) | acc]
    to_base(Integer.floor_div(number, base), base, acc)
  end

  defp invalid?(digits, base) do
    Enum.any?(digits, &(&1 < 0 || &1 >= base))
  end
end
