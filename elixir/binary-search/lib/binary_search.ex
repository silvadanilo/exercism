defmodule BinarySearch do
  @doc """
    Searches for a key in the tuple using the binary search algorithm.
    It returns :not_found if the key is not in the tuple.
    Otherwise returns {:ok, index}.

    ## Examples

      iex> BinarySearch.search({}, 2)
      :not_found

      iex> BinarySearch.search({1, 3, 5}, 2)
      :not_found

      iex> BinarySearch.search({1, 3, 5}, 5)
      {:ok, 2}

  """

  @spec search(tuple, integer) :: {:ok, integer} | :not_found
  def search(numbers, key) do
    bsearch(numbers, key, {0, tuple_size(numbers) - 1})
  end

  defp bsearch(_numbers, _key, {_min_index, max_index}) when max_index < 0, do: :not_found

  defp bsearch(numbers, key, {min_index, max_index}) do
    index = div(min_index + max_index, 2)
    middle_element = elem(numbers, index)

    cond do
      key == middle_element -> {:ok, index}
      min_index == max_index -> :not_found
      key > middle_element -> bsearch(numbers, key, {index + 1, max_index})
      key < middle_element -> bsearch(numbers, key, {min_index, index - 1})
    end
  end
end
