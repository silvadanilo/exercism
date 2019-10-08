defmodule Transpose do
  @doc """
  Given an input text, output it transposed.

  Rows become columns and columns become rows. See https://en.wikipedia.org/wiki/Transpose.

  If the input has rows of different lengths, this is to be solved as follows:
    * Pad to the left with spaces.
    * Don't pad to the right.

  ## Examples
  iex> Transpose.transpose("ABC\nDE")
  "AD\nBE\nC"

  iex> Transpose.transpose("AB\nDEF")
  "AD\nBE\n F"
  """

  @spec transpose(String.t()) :: String.t()
  def transpose("") do
    ""
  end

  def transpose(input) do
    lines = input
            |> String.split("\n")

    max_length = longer_line_length(lines)

    lines
    |> balancing_lines_length(max_length)
    |> Enum.map(&String.codepoints/1)
    |> Enum.zip()
    |> Enum.map(&Tuple.to_list/1)
    |> Enum.map(&Enum.join/1)
    |> Enum.join("\n")
    |> String.trim()
  end

  defp longer_line_length(lines) do
    lines
    |> Enum.map(&String.length/1)
    |> Enum.max()
  end

  defp balancing_lines_length(lines, length) do
    lines
    |> Enum.map(&(String.pad_trailing(&1, length)))
  end
end
