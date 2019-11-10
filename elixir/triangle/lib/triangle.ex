defmodule Triangle do
  @type kind :: :equilateral | :isosceles | :scalene

  # defguardp is_positive(a) when (is_integer(a) or is_float(a)) and a > 0
  # defguardp is_positive(a) when (is_integer(a) or is_float(a)) and a > 0
  defguardp side_lenghts_are_valid(a, b, c) when a + b > c and b + c > a and a + c > b



  @doc """
  Return the kind of triangle of a triangle with 'a', 'b' and 'c' as lengths.
  """
  @spec kind(number, number, number) :: {:ok, kind} | {:error, String.t()}
  def kind(a, b, c) when a <= 0 or b <= 0 or c <= 0, do: {:error, "all side lengths must be positive"}
  def kind(a, b, c) when not side_lenghts_are_valid(a, b, c), do: {:error, "side lengths violate triangle inequality"}

  def kind(a, a, a), do: {:ok, :equilateral}

  def kind(_, a, a), do: {:ok, :isosceles}
  def kind(a, _, a), do: {:ok, :isosceles}
  def kind(a, a, _), do: {:ok, :isosceles}

  def kind(_a, _b, _c), do: {:ok, :scalene}
end
