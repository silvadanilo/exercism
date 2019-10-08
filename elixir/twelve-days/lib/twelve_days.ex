defmodule TwelveDays do
  @suffixes %{
    1 => "a Partridge in a Pear Tree.",
    2 => "two Turtle Doves",
    3 => "three French Hens",
    4 => "four Calling Birds",
    5 => "five Gold Rings",
    6 => "six Geese-a-Laying",
    7 => "seven Swans-a-Swimming",
    8 => "eight Maids-a-Milking",
    9 => "nine Ladies Dancing",
    10 => "ten Lords-a-Leaping",
    11 => "eleven Pipers Piping",
    12 => "twelve Drummers Drumming"
  }

  @doc """
  Given a `number`, return the song's verse for that specific day, including
  all gifts for previous days in the same line.
  """
  @spec verse(number :: integer) :: String.t()
  def verse(number) do
    "On the #{day(number)} day of Christmas my true love gave to me: #{suffix(number)}"
  end

  @doc """
  Given a `starting_verse` and an `ending_verse`, return the verses for each
  included day, one per line.
  """
  @spec verses(starting_verse :: integer, ending_verse :: integer) :: String.t()
  def verses(starting_verse, ending_verse) do
    starting_verse .. ending_verse
    |> Enum.map(&verse/1)
    |> Enum.join("\n")
  end

  @doc """
  Sing all 12 verses, in order, one verse per line.
  """
  @spec sing() :: String.t()
  def sing do
    verses(1, 12)
  end

  defp suffix(number) do
    suffix("", number)
  end

  defp suffix("", 1) do
    @suffixes[1]
  end

  defp suffix(acc, 1) do
    "#{acc}, and #{@suffixes[1]}"
  end

  defp suffix("", number) do
    suffix(@suffixes[number], number - 1)
  end

  defp suffix(acc, number) do
    acc = "#{acc}, #{@suffixes[number]}"
    suffix(acc, number - 1)
  end


  defp day(1), do: "first"
  defp day(2), do: "second"
  defp day(3), do: "third"
  defp day(4), do: "fourth"
  defp day(5), do: "fifth"
  defp day(6), do: "sixth"
  defp day(7), do: "seventh"
  defp day(8), do: "eighth"
  defp day(9), do: "ninth"
  defp day(10), do: "tenth"
  defp day(11), do: "eleventh"
  defp day(12), do: "twelfth"
end
