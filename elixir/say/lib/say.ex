defmodule Say do
  @min 0
  @max 999_999_999_999

  @special_case_labels %{
    0 => "zero",
    1 => "one",
    2 => "two",
    3 => "three",
    4 => "four",
    5 => "five",
    6 => "six",
    7 => "seven",
    8 => "eight",
    9 => "nine",
    10 => "ten",
    11 => "eleven",
    12 => "twelve",
    13 => "thirteen",
    14 => "fourteen",
    15 => "fifteen",
    16 => "sixteen",
    17 => "seventeen",
    18 => "eighteen",
    19 => "nineteen",
    20 => "twenty",
    30 => "thirty",
    40 => "forty",
    50 => "fifty",
    60 => "sixty",
    70 => "seventy",
    80 => "eighty",
    90 => "ninety"
  }

  @special_cases Map.keys(@special_case_labels)

  @scales %{
    100 => "hundred",
    1_000 => "thousand",
    1_000_000 => "million",
    1_000_000_000 => "billion"
  }

  @doc """
  Translate a positive integer into English.
  """
  @spec in_english(integer) :: {atom, String.t()}
  def in_english(number) when number < @min or number > @max, do: {:error, "number is out of range"}
  def in_english(number), do: {:ok, do_in_english(number)}

  defp do_in_english(number) when number in @special_cases, do: Map.get(@special_case_labels, number)

  defp do_in_english(number) when number < 100 do
    [dec, units] = Integer.digits(number)
    "#{do_in_english(dec * 10)}-#{do_in_english(units)}"
  end

  for {scale, label} <- Enum.reverse(@scales) do
    defp do_in_english(number) when rem(number, unquote(scale)) == 0,
      do: do_in_english(div(number, unquote(scale))) <> " #{unquote(label)}"

    defp do_in_english(number) when number > unquote(scale),
      do:
        do_in_english(div(number, unquote(scale))) <>
          " #{unquote(label)} " <> do_in_english(rem(number, unquote(scale)))
  end

  # This also works but probably less readable
  # defp do_in_english(number) do
  #   Stream.transform(
  #     Enum.reverse(@scales),
  #     fn -> number end,
  #     fn {scale, label}, number ->
  #       case {div(number, scale), rem(number, scale)} |> IO.inspect(label: "#### #{scale} ######") do
  #         {0, 0} -> {:halt, number}
  #         {0, r} -> {[], r}
  #         {n, r} -> {["#{do_in_english(n)} #{label}"], r}
  #       end
  #     end,
  #     fn
  #       0 -> {:halt, 0}
  #       number -> {[do_in_english(number)], nil}
  #     end,
  #     fn _ -> nil end
  #   )
  #   |> Enum.join(" ")
  # end
end
