defmodule House do
  @partial_sentences %{
    1 => "the house that Jack built.",
    2 => "the malt that lay in",
    3 => "the rat that ate",
    4 => "the cat that killed",
    5 => "the dog that worried",
    6 => "the cow with the crumpled horn that tossed",
    7 => "the maiden all forlorn that milked",
    8 => "the man all tattered and torn that kissed",
    9 => "the priest all shaven and shorn that married",
    10 => "the rooster that crowed in the morn that woke",
    11 => "the farmer sowing his corn that kept",
    12 => "the horse and the hound and the horn that belonged to"
  }

  @doc """
  Return verses of the nursery rhyme 'This is the House that Jack Built'.
  """
  @spec recite(start :: integer, stop :: integer) :: String.t()
  def recite(start, stop) do
    start..stop
    |> Enum.map(&recite(&1))
    |> Enum.join()
  end

  def recite(line) do
    phrase =
      line..1
      |> Enum.map(&@partial_sentences[&1])
      |> Enum.join(" ")

    "This is #{phrase}\n"
  end
end
