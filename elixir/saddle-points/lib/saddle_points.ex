defmodule SaddlePoints do
  @doc """
  Parses a string representation of a matrix
  to a list of rows
  """
  @spec rows(String.t()) :: [[integer]]
  def rows(str) do
    str
    |> String.split("\n")
    |> Enum.map(&String.split(&1, " "))
    |> Enum.map(fn values -> Enum.map(values, &String.to_integer/1) end)
  end

  @doc """
  Parses a string representation of a matrix
  to a list of columns
  """
  @spec columns(String.t()) :: [[integer]]
  def columns(str) do
    str
    |> rows()
    |> transpose()
  end

  @doc """
  Calculates all the saddle points from a string
  representation of a matrix
  """
  @spec saddle_points(String.t()) :: [{integer, integer}]
  def saddle_points(str) do
    for {row, row_index} <- rows(str) |> Enum.with_index(),
        {col, col_index} <- columns(str) |> Enum.with_index(),
        Enum.max(row) == Enum.min(col),
        do: {row_index, col_index}
  end

  defp transpose(data) do
    data
    |> Enum.zip()
    |> Enum.map(&Tuple.to_list/1)
  end
end
