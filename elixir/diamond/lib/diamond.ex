defmodule Diamond do
  @doc """
  Given a letter, it prints a diamond starting with 'A',
  with the supplied letter at the widest point.
  """
  @spec build_shape(char) :: String.t()
  def build_shape(letter) do
    letter
    |> build_top()
    |> mirror()
    |> Enum.join("\n")
    |> Kernel.<>("\n")
  end

  defp build_top(letter) do
    line_length = (letter - ?A) * 2 + 1

    ?A..letter
    |> Enum.map(&(single_line_output(&1, line_length)))
  end

  defp mirror(top) do
    bottom = tl(Enum.reverse(top))
    top ++ bottom
  end

  defp single_line_output(?A, line_length) do
    :string.centre('A', line_length)
  end

  defp single_line_output(letter, line_length) do
    distance = (letter - ?A) * 2 - 1

    :string.centre(
      String.to_charlist(<<letter::utf8>> <> pad(distance) <> <<letter::utf8>> ),
      line_length
    )
  end

  defp pad(n) do
    String.duplicate(" ", n)
  end
end
