defmodule Luhn do
  import Integer, only: [is_odd: 1]

  @doc """
  Checks if the given number is valid via the luhn formula
  """
  @spec valid?(String.t()) :: boolean
  def valid?(number) do
    with {:ok, number} <- parse(number) do
      number
      |> split_in_digits()
      |> has_a_valid_luhn_sum?()
    else
      _ -> false
    end
  end

  defp parse(number) do
    number = String.replace(number, " ", "")

    if String.match?(number, ~r/^\d{2,}$/) do
      {:ok, number}
    else
      {:error, :invalid_number}
    end
  end

  defp split_in_digits(number) do
    number
    |> String.reverse()
    |> String.codepoints()
    |> Enum.map(&String.to_integer/1)
  end

  defp has_a_valid_luhn_sum?(digits) do
    digits
    |> double_every_second_digit
    |> Enum.sum()
    |> rem(10) == 0
  end

  defp double_every_second_digit(digits) do
    digits
    |> Enum.with_index()
    |> Enum.map(&double_digit/1)
    |> Enum.map(&cast_to_single_digit/1)
  end

  defp double_digit({digit, index}) when Integer.is_odd(index), do: digit * 2
  defp double_digit({digit, _}), do: digit

  defp cast_to_single_digit(number) when number > 9, do: number - 9
  defp cast_to_single_digit(number), do: number
end
