defmodule Proverb do
  @doc """
  Generate a proverb from a list of strings.
  """
  @spec recite(strings :: [String.t()]) :: String.t()
  def recite(strings) do
    strings
    |> Enum.chunk_every(2, 1)
    |> Enum.map(fn
      [a, b] -> "For want of a #{a} the #{b} was lost.\n"
      [_] -> "And all for the want of a #{List.first(strings)}.\n"
    end)
    |> Enum.join()
  end
end
