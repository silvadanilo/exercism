defmodule Words do
  @doc """
  Count the number of words in the sentence.

  Words are compared case-insensitively.
  """
  @spec count(String.t()) :: map
  def count(sentence) do
    sentence
    |> String.downcase()
    |> split_on_non_alphanumeric_chars()
    |> Enum.reduce(Map.new(), fn word, acc ->
      Map.update(acc, word, 1, &(&1 + 1))
    end)
  end

  defp split_on_non_alphanumeric_chars(sentence) do
    String.split(sentence, ~r/[^-[:alnum:]]/u, trim: true)
  end
end
