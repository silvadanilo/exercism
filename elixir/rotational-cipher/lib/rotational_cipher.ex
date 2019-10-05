defmodule RotationalCipher do
  @doc """
  Given a plaintext and amount to shift by, return a rotated string.

  Example:
  iex> RotationalCipher.rotate("Attack at dawn", 13)
  "Nggnpx ng qnja"
  """
  @n_chars 26

  @spec rotate(text :: String.t(), shift :: integer) :: String.t()
  def rotate(text, shift) do
    rotate_char = fn
      c when c in ?a..?z -> ?a + rem(c + shift - ?a, @n_chars)
      c when c in ?A..?Z -> ?A + rem(c + shift - ?A, @n_chars)
      c -> c
    end

    text
    |> String.to_charlist()
    |> Enum.map(&rotate_char.(&1))
    |> to_string
  end
end
