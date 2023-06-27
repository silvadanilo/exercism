defmodule BookStore do
  @typedoc "A book is represented by its number in the 5-book series"
  @type book :: 1 | 2 | 3 | 4 | 5

  @book_price 800
  @bucket_price %{
    1 => @book_price,
    2 => @book_price * 2 * 0.95,
    3 => @book_price * 3 * 0.90,
    4 => @book_price * 4 * 0.80,
    5 => @book_price * 5 * 0.75
  }

  @doc """
  Calculate lowest price (in cents) for a shopping basket containing books.
  This solutions works because all the books have the same price
  """
  @spec total(basket :: [book]) :: integer
  def total(basket) do
    basket
    |> frequencies()
    |> permutations(5)
    |> Enum.map(&bucket_price/1)
    |> Enum.min()
  end

  ~S"""
  It return the frequencies of every single book
  in descending order, from the most purchased to the least
  ## Examples
      iex> frequencies([1, 1, 2, 2, 3, 3, 4, 5])
      [2, 2, 2, 1, 1]
  """
  defp frequencies(basket) do
    basket
    |> Enum.frequencies()
    |> Map.values()
    |> Enum.sort(:desc)
  end

  ~S"""
  It return all possible bucket suddivision
  ## Examples
      iex> permutations([2, 2, 2, 1, 1])
      [[5, 3], [4, 4], [3, 3, 2], [2, 2, 2, 2], [1, 1, 1, 1, 1, 1, 1, 1]]
  """
  defp permutations(_book_counts, 0), do: []
  defp permutations(book_counts, n) do
    [
      Stream.unfold({book_counts, n}, fn
        {_, 0} ->
          nil

        {book_counts, n} ->
          case pick(book_counts, n) do
            {:ok, left} -> {n, {left, n}}
            :error -> {0, {book_counts, n - 1}}
          end
      end)
      |> Enum.reject(&(&1 == 0))
    ] ++ permutations(book_counts, n - 1)
  end

  ~S"""
  It return :ok if is possible to get a bucket of size n with the available_books, and the left books after bucket formation
  It return :error when is not possible to make a bucket of size n
  ## Examples
      iex> pick([2, 2, 2, 1, 1], 5)
      {:ok, [1, 1, 1, 0, 0]}

      iex> pick([2, 2, 2, 1, 1], 2)
      {:ok, [1, 1, 2, 1, 1]}

      iex> pick([1, 0, 0, 0, 0], 2)
      :error
  """
  defp pick(book_counts, n) do
    if Enum.count(book_counts) >= n do
      {:ok, drop_bucket(book_counts, n)}
    else
      :error
    end
  end

  defp drop_bucket(book_counts, n) do
    book_counts
    |> Enum.with_index()
    |> Enum.map(fn {count, index} -> if index < n, do: count - 1, else: count end)
    |> Enum.reject(& &1 == 0)
  end

  defp bucket_price(buckets) do
    buckets
    |> Enum.map(fn bucket -> @bucket_price[bucket] end)
    |> Enum.sum()
  end
end
