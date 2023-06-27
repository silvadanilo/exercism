defmodule ResistorColorTrio do
  @colors %{
    black: 0,
    brown: 1,
    red: 2,
    orange: 3,
    yellow: 4,
    green: 5,
    blue: 6,
    violet: 7,
    grey: 8,
    white: 9
  }

  @formats [
    {:gigaohms, 1_000_000_000},
    {:megaohms, 1_000_000},
    {:kiloohms, 1_000}
  ]

  @doc """
  Calculate the resistance value in ohms from resistor colors
  """
  @spec label(colors :: [atom]) :: {number, :ohms | :kiloohms | :megaohms | :gigaohms}
  def label(colors) do
    colors
    |> Enum.take(2)
    |> Enum.map(fn color -> @colors[color] end)
    |> Integer.undigits()
    |> Kernel.*(10 ** how_many_zeroes(colors))
    |> format()
  end

  defp how_many_zeroes(colors) do
    Map.get(@colors, Enum.at(colors, 2), nil)
  end

  for {label, units} <- @formats do
    defp format(ohms) when ohms >= unquote(units), do: {div(ohms, unquote(units)), unquote(label)}
  end

  defp format(ohms), do: {ohms, :ohms}

  # defp format(ohms) when ohms >= 1_000_000_000, do: {div(ohms, 1_000_000_000), :gigaohms}
  # defp format(ohms) when ohms >= 1_000_000, do: {div(ohms, 1_000_000), :megaohms}
  # defp format(ohms) when ohms >= 1_000, do: {div(ohms, 1000), :kiloohms}
end
