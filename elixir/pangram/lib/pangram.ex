defmodule Pangram do
  @doc """
  Determines if a word or sentence is a pangram.
  A pangram is a sentence using every letter of the alphabet at least once.

  Returns a boolean.

    ## Examples

      iex> Pangram.pangram?("the quick brown fox jumps over the lazy dog")
      true

  """

  @spec pangram?(String.t()) :: boolean
  def pangram?(sentence) do
    all_chars() -- codepoints_in_sentence(sentence)
    |> Enum.count() == 0
  end

  defp all_chars(), do: "abcdefghijklmnopqrstuvwxyz" |> String.codepoints()

  defp codepoints_in_sentence(sentence) do
    sentence
    |> String.downcase()
    |> String.codepoints()
  end
end
