defmodule MatchingBrackets do
  @brackets %{
    "{" => "}",
    "[" => "]",
    "(" => ")",
  }

  @doc """
  Checks that all the brackets and braces in the string are matched correctly, and nested correctly
  """
  @spec check_brackets(String.t()) :: boolean
  def check_brackets(str) when is_binary(str) do
    str
    |> String.codepoints()
    |> check_brackets({})
  end

  def check_brackets([], {}), do: true
  def check_brackets([], _), do: false

  def check_brackets([h | t], stack) when h in ["(", "[", "{"] do
    check_brackets(t, {@brackets[h], stack})
  end

  def check_brackets([h | t], {last, left}) when h in [")", "]", "}"] do
    if last == h do
      check_brackets(t, left)
    else
      false
    end
  end

  def check_brackets([_ | t], stack) do
    check_brackets(t, stack)
  end
end
