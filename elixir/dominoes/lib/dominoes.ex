defmodule Dominoes do
  @type domino :: {1..6, 1..6}

  @doc """
  chain?/1 takes a list of domino stones and returns boolean indicating if it's
  possible to make a full chain
  """
  @spec chain?(dominoes :: [domino]) :: boolean
  def chain?([]), do: true
  def chain?([{a, a}]), do: true
  def chain?([{_, _}]), do: false

  def chain?([{left_dots, right_dots} | dominoes]) do
    Enum.any?(dominoes, fn
      {^left_dots, x} = match -> chain?([{x, right_dots} | List.delete(dominoes, match)])
      {x, ^left_dots} = match -> chain?([{x, right_dots} | List.delete(dominoes, match)])
      _ -> false
    end)
  end
end
