defmodule GuessingGame do
  def compare(secret_number, guess \\ :no_guess)

  def compare(_secret_number, :no_guess), do: "Make a guess"

  def compare(secret_number, secret_number), do: "Correct"

  def compare(secret_number, guess) when secret_number - guess in [1, -1], do: "So close"

  def compare(secret_number, guess) when guess > secret_number, do: "Too high"

  def compare(_secret_number, _guess), do: "Too low"
end
