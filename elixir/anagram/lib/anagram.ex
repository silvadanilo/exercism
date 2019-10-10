defmodule Anagram do
  @doc """
  Returns all candidates that are anagrams of, but not equal to, 'base'.
  """
  @spec match(String.t(), [String.t()]) :: [String.t()]
  def match(base, candidates) do
    base_list = codepoints(base)
    candidates
    |> Enum.filter(&(do_match(base_list, codepoints(&1))))
  end

  defp do_match(base, candidate) when base == candidate, do: false

  defp do_match(base, candidate) do
    candidate -- base == []
    &&
    base -- candidate == []
  end

  defp codepoints(string) do
    string
    |> String.downcase()
    |> String.codepoints()
  end





  ###################################################
  ## Trying to implement without the `--` operator
  ###################################################
  @spec match(String.t(), [String.t()]) :: [String.t()]
  def match(base, candidate) when is_binary(candidate) and base == candidate, do: false

  def match(base, candidate) when is_binary(candidate) do
    do_match(Enum.sort(codepoints(base)), Enum.sort(codepoints(candidate)), true)
  end

  def match(base, candidates) do
    candidates
    |> Enum.filter(&(match(String.downcase(base), String.downcase(&1))))
  end

  defp do_match([], [], acc), do: acc
  defp do_match(base, candidate, _acc) when length(base) != length(candidate), do: false

  defp do_match([bc | btail], [cc| ctail], acc) do
    do_match(btail, ctail, acc && bc == cc)
  end

  defp codepoints(string) do
    string
    |> String.codepoints()
  end
end
