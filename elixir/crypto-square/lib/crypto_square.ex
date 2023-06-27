defmodule CryptoSquare do
  @doc """
  Encode string square methods
  ## Examples

    iex> CryptoSquare.encode("abcd")
    "ac bd"
  """
  @spec encode(String.t()) :: String.t()
  def encode(str) do
    str
    |> normalize()
    |> square()
  end

  defp square(""), do: ""

  defp square(str) do
    {columns_size, rows_size} = square_size(str)

    str
    |> String.pad_trailing(columns_size * rows_size)
    |> String.graphemes()
    |> Enum.chunk_every(columns_size)
    |> Enum.zip_with(fn chars -> Enum.join(chars) end)
    |> Enum.join(" ")
  end

  defp normalize(str) do
    str
    |> String.downcase()
    |> String.replace(~r/[^[:alnum:]]/, "")
  end

  defp square_size(str) do
    columns = str |> String.length() |> :math.sqrt() |> ceil()
    rows = if columns * (columns - 1) >= String.length(str), do: columns - 1, else: columns

    {columns, rows}
  end
end
