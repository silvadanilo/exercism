defmodule Forth do
  @type t :: %Forth{manipulators: Map.t, stack: List.t}
  defstruct manipulators: %{}, stack: []
  @opaque evaluator :: Forth.t


  @doc """
  Create a new evaluator.
  """
  @spec new() :: evaluator
  def new() do
    %Forth{}
  end

  @doc """
  Evaluate an input string, updating the evaluator state.
  """
  @spec eval(evaluator, String.t()) :: evaluator
  def eval(ev, s) do
    case String.match?(s, ~r{^:.*;$}) do
      true -> parse_definition(ev, s)
      false -> parse(ev, s)
    end
  end

  defp parse_definition(ev = %{manipulators: manipulators}, s) do
    [manipulator | mapto] =
      s
      |> String.split(~r{[^0-9A-Za-z+*-/]}u, trim: true)
      |> extract_manipulator()

    %{ev | manipulators: Map.update(manipulators, manipulator, mapto, fn _ -> mapto end)}
  end

  defp parse(ev, s) do
    stack =
      s
      |> tokenize()
      |> Enum.reduce(ev, &process/2)
      |> Map.get(:stack)

    %{ev | stack: stack}
  end

  defp process(number, ev = %{stack: stack}) when is_integer(number) do
    %{ev | stack: stack ++ [number]}
  end

  defp process(token, ev = %{stack: stack}) do
    if token in Map.keys(ev.manipulators) do
      ev.manipulators
      |> Map.get(token)
      |> Enum.reduce(ev, fn token, ev -> process(token, ev) end)
    else
      stack =
        case String.upcase(token) do
          "+" -> sum(stack)
          "-" -> substraction(stack)
          "*" -> multiplication(stack)
          "/" -> division(stack)
          "DUP" -> dup(stack)
          "DROP" -> drop(stack)
          "SWAP" -> swap(stack)
          "OVER" -> over(stack)
          unknown -> raise Forth.UnknownWord, word: unknown
        end

      %{ev | stack: stack}
    end
  end

  defp sum(stack), do: stack |> Enum.sum() |> List.duplicate(1)

  defp substraction([first_element | tail]) do
    tail
    |> Enum.reduce(first_element, fn n, ev -> ev - n end)
    |> List.duplicate(1)
  end

  defp multiplication([first_element | tail]) do
    tail
    |> Enum.reduce(first_element, fn n, ev -> ev * n end)
    |> List.duplicate(1)
  end

  defp division([_single_element]), do: raise(Forth.DivisionByZero)

  defp division([first_element | tail]) do
    tail
    |> Enum.reduce(first_element, fn n, ev -> div(ev, n) end)
    |> List.duplicate(1)
  end

  defp dup([]), do: raise(Forth.StackUnderflow)
  defp dup(ev), do: ev ++ [List.last(ev)]

  defp drop([]), do: raise(Forth.StackUnderflow)

  defp drop(ev) do
    {_e, ev} = List.pop_at(ev, -1)
    ev
  end

  defp swap(ev) when length(ev) < 2, do: raise(Forth.StackUnderflow)

  defp swap(ev) do
    {last, ev} = List.pop_at(ev, -1)
    {second_last, ev} = List.pop_at(ev, -1)
    ev ++ [last, second_last]
  end

  defp over(ev) when length(ev) < 2, do: raise(Forth.StackUnderflow)

  defp over(ev) do
    {last, ev} = List.pop_at(ev, -1)
    {second_last, ev} = List.pop_at(ev, -1)
    ev ++ [second_last, last, second_last]
  end

  @doc """
  Return the current stack as a string with the element on top of the stack
  being the rightmost element in the string.
  """
  @spec format_stack(evaluator) :: String.t()
  def format_stack(%{stack: stack}) do
    stack
    |> Enum.join(" ")
  end

  defp tokenize(s) do
    s
    |> String.split(~r{[^0-9A-Za-z+*-/]}u, trim: true)
    |> Enum.map(&cast_to_int/1)
  end

  defp cast_to_int(word) do
    if Regex.match?(~r{\d+}, word) do
      String.to_integer(word)
    else
      word
    end
  end

  defp extract_manipulator(tokens = [key | values]) do
    cond do
      Enum.any?(tokens, fn token -> Integer.parse(token) != :error end) -> raise Forth.InvalidWord
      true -> [key | values]
    end
  end

  defmodule StackUnderflow do
    defexception []
    def message(_), do: "stack underflow"
  end

  defmodule InvalidWord do
    defexception word: nil
    def message(e), do: "invalid word: #{inspect(e.word)}"
  end

  defmodule UnknownWord do
    defexception word: nil
    def message(e), do: "unknown word: #{inspect(e.word)}"
  end

  defmodule DivisionByZero do
    defexception []
    def message(_), do: "division by zero"
  end
end
