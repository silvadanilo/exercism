defmodule RomanNumerals do
  @doc """
  Convert the number to a roman number.
  """

  @symbols [
    M: 1000,
    CM: 900,
    D: 500,
    CD: 400,
    C: 100,
    XC: 90,
    L: 50,
    XL: 40,
    X: 10,
    IX: 9,
    V: 5,
    IV: 4,
    I: 1
  ]

  @spec numeral(pos_integer) :: String.t()
  def numeral(number) do
    case Enum.find(@symbols, fn {_, value} -> number >= value end) do
      nil -> ""
      {label, value} -> Atom.to_string(label) <> numeral(number - value)
    end
  end
end
