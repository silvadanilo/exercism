defmodule OcrNumbers do
  @doc """
  Given a 3 x 4 grid of pipes, underscores, and spaces, determine which number is represented, or
  whether it is garbled.
  """
  @spec convert([String.t()]) :: String.t()
  def convert(input) do
    with :ok <- check_matrix_width(input),
         :ok <- check_matrix_height(input)
    do
        input
        |> split_by_rows()
        |> Enum.map(&parse_row/1)
        |> Enum.join(",")
        |> (&({:ok, &1})).()
    end
  end

  defp split_by_rows(input), do: input |> Enum.chunk_every(4)

  defp check_matrix_height(input) do
    if rem(length(input), 4) !== 0 do
      {:error, 'invalid line count'}
    else
      :ok
    end
  end

  defp check_matrix_width(input) do
    input
    |> Enum.all?(fn line -> rem(String.length(line), 3) === 0 end)
    |> case do
      true -> :ok
      false -> {:error, 'invalid column count'}
    end
  end

  defp parse_row(input) do
    input
    |> Enum.reduce([], &split_by_digits/2)
    |> List.zip()
    |> Enum.map(&convert_digit/1)
    |> Enum.join()
  end

  defp split_by_digits(line, acc) do
    ocr_digits = line
        |> String.codepoints()
        |> Enum.chunk_every(3)
        |> Enum.map(&Enum.join/1)

    [ocr_digits | acc]
  end

  defp convert_digit(exploded) do
    case exploded do
      {"   ", "|_|", "| |", " _ "} -> "0"
      {"   ", "  |", "  |", "   "} -> "1"
      {"   ", "|_ ", " _|", " _ "} -> "2"
      {"   ", " _|", " _|", " _ "} -> "3"
      {"   ", "  |", "|_|", "   "} -> "4"
      {"   ", " _|", "|_ ", " _ "} -> "5"
      {"   ", "|_|", "|_ ", " _ "} -> "6"
      {"   ", "  |", "  |", " _ "} -> "7"
      {"   ", "|_|", "|_|", " _ "} -> "8"
      {"   ", " _|", "|_|", " _ "} -> "9"
      _ -> "?"
    end
  end
end
