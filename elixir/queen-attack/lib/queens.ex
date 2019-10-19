defmodule Queens do
  @type t :: %Queens{black: {integer, integer}, white: {integer, integer}}
  defstruct black: nil, white: nil

  @doc """
  Creates a new set of Queens
  """
  @spec new() :: Queens.t()
  @spec new({integer, integer}, {integer, integer}) :: Queens.t()
  def new(white \\ {0, 3}, black \\ {7, 3})
  def new(same, same), do: raise(ArgumentError)

  def new(white, black) do
    %Queens{white: white, black: black}
  end

  @doc """
  Gives a string representation of the board with
  white and black queen locations shown
  """
  @spec to_string(Queens.t()) :: String.t()
  def to_string(queens) do
    board =
      for x <- 0..7 do
        for y <- 0..7 do
          print_cell({x, y}, queens)
        end
      end

    board
    |> Enum.map(&Enum.join(&1, " "))
    |> Enum.join("\n")
  end

  defp print_cell({x, y}, %Queens{white: {x, y}}), do: "W"
  defp print_cell({x, y}, %Queens{black: {x, y}}), do: "B"
  defp print_cell(_, _), do: "_"

  @doc """
  Checks if the queens can attack each other
  """
  @spec can_attack?(Queens.t()) :: boolean
  def can_attack?(%Queens{white: {wx, wy}, black: {bx, by}}) when wx == bx or wy == by, do: true

  def can_attack?(%Queens{white: {wx, wy}, black: {bx, by}}) do
    abs(wx - wy) == abs(bx - by)
  end

  def can_attack?(_), do: false
end
