defmodule Frequency do
  @doc """
  Count letter frequency in parallel.

  Returns a map of characters to frequencies.

  The number of worker processes to use can be set with 'workers'.
  """
  @spec frequency([String.t()], pos_integer) :: map
  def frequency([], _), do: %{}

  def frequency(texts, 1) do
    texts
    |> into_graphemes()
    |> do_frequency()
  end

  def frequency(texts, workers) do
    texts
    |> into_graphemes()
    |> split_into_chunks(workers)
    |> split_work()
    |> Enum.reduce(%{}, fn {:ok, single_result}, acc ->
      Map.merge(acc, single_result, fn _k, v1, v2 -> v1 + v2 end)
    end)
  end

  defp into_graphemes(texts) do
    texts
    |> Enum.join()
    |> String.graphemes()
  end

  defp split_into_chunks(graphemes, chuncks) do
    count = Enum.count(graphemes)
    graphemes_per_chunk = Kernel.trunc(Float.ceil(count / chuncks))

    Enum.chunk_every(graphemes, graphemes_per_chunk)
  end

  defp split_work(graphemes) do
    Task.async_stream(graphemes, __MODULE__, :do_frequency, [])
  end

  def do_frequency(graphemes) do
    Enum.reduce(graphemes, %{}, fn grapheme, acc ->
      if (String.match?(grapheme, ~r/^\p{L}$/u)) do
        Map.update(acc, String.downcase(grapheme), 1, &(&1 + 1))
      else
        acc
      end
    end)
  end
end
