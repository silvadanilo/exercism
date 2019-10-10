defmodule Phone do
  @doc """
  Remove formatting from a phone number.

  Returns "0000000000" if phone number is not valid
  (10 digits or "1" followed by 10 digits)

  ## Examples

  iex> Phone.number("212-555-0100")
  "2125550100"

  iex> Phone.number("+1 (212) 555-0100")
  "2125550100"

  iex> Phone.number("+1 (212) 055-0100")
  "0000000000"

  iex> Phone.number("(212) 555-0100")
  "2125550100"

  iex> Phone.number("867.5309")
  "0000000000"
  """
  @error {:error, "0000000000"}

  @spec number(String.t()) :: String.t()
  def number(raw) do
    with {:ok, cleaned} <- remove_puntuaction(raw),
         {:ok, cleaned} <- contains_only_digits?(cleaned),
         {:ok, cleaned} <- remove_country_code(cleaned),
         {:ok, cleaned} <- check_area_code(cleaned),
         {:ok, cleaned} <- check_exchange_code(cleaned)
    do
      cleaned
    else
      {:error, msg} -> msg
    end
  end

  defp remove_puntuaction(raw) do
    {:ok, Regex.replace(~r{[+()-\. ]*}, raw, "")}
  end

  defp contains_only_digits?(number) do
    if Regex.match?(~r/^\d{10,11}$/, number) do
      {:ok, number}
    else
      @error
    end
  end

  defp remove_country_code(number), do: remove_country_code(number, String.length(number))
  defp remove_country_code("1" <> number, 11), do: {:ok, number}
  defp remove_country_code(_, 11), do: @error
  defp remove_country_code(number, 10), do: {:ok, number}

  defp check_area_code("0" <> _), do: @error
  defp check_area_code("1" <> _), do: @error
  defp check_area_code(number), do: {:ok, number}

  defp check_exchange_code(number) do
    case exchange_number(number) do
      "0" <> _ -> @error
      "1" <> _ -> @error
      _ -> {:ok, number}
    end
  end

  defp exchange_number(number) do
    String.slice(number, 3, 3)
  end

  @doc """
  Extract the area code from a phone number

  Returns the first three digits from a phone number,
  ignoring long distance indicator

  ## Examples

  iex> Phone.area_code("212-555-0100")
  "212"

  iex> Phone.area_code("+1 (212) 555-0100")
  "212"

  iex> Phone.area_code("+1 (012) 555-0100")
  "000"

  iex> Phone.area_code("867.5309")
  "000"
  """
  @spec area_code(String.t()) :: String.t()
  def area_code(raw) do
    raw
    |> number()
    |> String.slice(0, 3)
  end

  @doc """
  Pretty print a phone number

  Wraps the area code in parentheses and separates
  exchange and subscriber number with a dash.

  ## Examples

  iex> Phone.pretty("212-555-0100")
  "(212) 555-0100"

  iex> Phone.pretty("212-155-0100")
  "(000) 000-0000"

  iex> Phone.pretty("+1 (303) 555-1212")
  "(303) 555-1212"

  iex> Phone.pretty("867.5309")
  "(000) 000-0000"
  """
  @spec pretty(String.t()) :: String.t()
  def pretty(raw) do
    raw
    |> number()
    |> String.replace(~r/(\d{3})(\d{3})(\d{4})/, "(\\1) \\2-\\3")
  end
end
