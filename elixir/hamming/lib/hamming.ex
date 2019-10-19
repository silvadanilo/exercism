defmodule Hamming do
  @doc """
  Returns number of differences between two strands of DNA, known as the Hamming Distance.

  ## Examples

  iex> Hamming.hamming_distance('AAGTCATA', 'TAGCGATC')
  {:ok, 4}
  """
  @spec hamming_distance([char], [char]) :: {:ok, non_neg_integer} | {:error, String.t()}
  def hamming_distance(identical, identical), do: {:ok, 0}

  def hamming_distance(strand1, strand2) when length(strand1) != length(strand2),
    do: {:error, "Lists must be the same length"}

  def hamming_distance(strand1, strand2) do
    count =
      Enum.zip(strand1, strand2)
      |> Enum.count(&(elem(&1, 0) != elem(&1, 1)))

    {:ok, count}
  end

  #######################################
  # WITH RECURSION and PATTERN MATCHING
  #######################################
  # def hamming_distance(strand1, strand2) do
  #   hamming_distance(0, strand1, strand2)
  # end

  # defp hamming_distance(count, [], []) do
  #   {:ok, count}
  # end

  # defp hamming_distance(count, [c | strand1], [c | strand2]) do
  #   hamming_distance(count, strand1, strand2)
  # end

  # defp hamming_distance(count, [_ | strand1], [_ | strand2]) do
  #   hamming_distance(count + 1, strand1, strand2)
  # end

end
