defmodule Bob do
  def hey(input) do
    cond do
      silence?(input) -> "Fine. Be that way!"
      yell_a_question?(input) -> "Calm down, I know what I'm doing!"
      question?(input) -> "Sure."
      yell?(input) -> "Whoa, chill out!"
      true -> "Whatever."
    end
  end

  defp silence?(input) do
    "" == String.trim(input)
  end

  defp yell_a_question?(input) do
    question?(input) and yell?(input)
  end

  defp yell?(input) do
    upcase = String.upcase(input)
    upcase == input && upcase != String.downcase(input)
  end

  defp question?(input) do
    String.ends_with?(input, "?")
  end
end
