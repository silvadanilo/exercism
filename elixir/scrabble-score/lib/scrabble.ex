defmodule Scrabble do
  @doc """
  Calculate the scrabble score for the word.
  """
  @spec score(String.t()) :: non_neg_integer
  def score("") do
    0
  end

  def score(word) do
    word
    |> String.downcase()
    |> String.codepoints()
    |> Enum.map(&letter_score/1)
    |> Enum.sum()
  end

  defp letter_score(l) do
    cond do
      l in ["a", "e", "i", "o", "u", "l", "n", "r", "s", "t"] -> 1
      l in ["d", "g"] -> 2
      l in ["b", "c", "m", "p"] -> 3
      l in ["f", "h", "v", "w", "y"] -> 4
      l in ["k"] -> 5
      l in ["j", "x"] -> 8
      l in ["q", "z"] -> 10
      true -> 0
    end
  end
end
