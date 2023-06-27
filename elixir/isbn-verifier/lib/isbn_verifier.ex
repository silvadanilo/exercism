defmodule IsbnVerifier do
  @isbn_format ~r/^\d{9}[\dX]$/

  @doc """
    Checks if a string is a valid ISBN-10 identifier

    ## Examples

      iex> IsbnVerifier.isbn?("3-598-21507-X")
      true

      iex> IsbnVerifier.isbn?("3-598-2K507-0")
      false

  """
  @spec isbn?(String.t()) :: boolean
  def isbn?(isbn) do
    with isbn <- String.replace(isbn, "-", ""),
         true <- String.match?(isbn, @isbn_format),
         digits <- to_digits(isbn),
         true <- valid_checksum?(digits) do
      true
    else
      _ -> false
    end
  end

  defp valid_checksum?(digits) do
    digits
    |> Enum.reverse()
    |> Enum.with_index()
    |> Enum.map(fn {digit, index} -> digit * (index + 1) end)
    |> Enum.sum()
    |> Integer.mod(11) == 0
  end

  defp to_digits(isbn) when is_binary(isbn) do
    isbn
    |> Integer.parse()
    |> to_digits()
  end

  defp to_digits({number, "X"}), do: Integer.digits(number) ++ [10]
  defp to_digits({number, ""}), do: Integer.digits(number)
end
