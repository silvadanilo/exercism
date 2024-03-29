defmodule Isogram do
  @doc """
  Determines if a word or sentence is an isogram
  """
  @spec isogram?(String.t()) :: boolean
  def isogram?(sentence) do
    sentence
    |> String.downcase()
    |> String.replace(~r/[^a-z]/, "")
    |> String.graphemes()
    |> Enum.frequencies()
    |> Enum.all?(fn {_, count} -> count == 1 end)
  end
end
