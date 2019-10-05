defmodule StringSeries do
  @doc """
  Given a string `s` and a positive integer `size`, return all substrings
  of that size. If `size` is greater than the length of `s`, or less than 1,
  return an empty list.
  """
  @spec slices(s :: String.t(), size :: integer) :: list(String.t())
  def slices(_, size) when size <= 0, do: []

  def slices(s, size) do
    length = String.length(s)
    cond do
      size > length ->
        []
      true ->
        0..(length - size)
        |> Enum.map(&(String.slice(s, &1, size)))
    end
  end
end
