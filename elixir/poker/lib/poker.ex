defmodule Poker do

  # @ranks [
  #   :highest, :pair, :two_pair,
  #   :tris, :straight, :flush,
  #   :full_house, :poker, :straight_flush
  # ]

  @doc """
  Given a list of poker hands, return a list containing the highest scoring hand.

  If two or more hands tie, return the list of tied hands in the order they were received.

  The basic rules and hand rankings for Poker can be found at:

  https://en.wikipedia.org/wiki/List_of_poker_hands

  For this exercise, we'll consider the game to be using no Jokers,
  so five-of-a-kind hands will not be tested. We will also consider
  the game to be using multiple decks, so it is possible for multiple
  players to have identical cards.

  Aces can be used in low (A 2 3 4 5) or high (10 J Q K A) straights, but do not count as
  a high card in the former case.

  For example, (A 2 3 4 5) will lose to (2 3 4 5 6).

  You can also assume all inputs will be valid, and do not need to perform error checking
  when parsing card values. All hands will be a list of 5 strings, containing a number
  (or letter) for the rank, followed by the suit.

  Ranks (lowest to highest): 2 3 4 5 6 7 8 9 10 J Q K A
  Suits (order doesn't matter): C D H S

  Example hand: ~w(4S 5H 4C 5D 4H) # Full house, 5s over 4s
  """
  @spec best_hand(list(list(String.t()))) :: list(list(String.t()))
  def best_hand(hands) do
    hands
    |> Enum.map(&parse/1)
    |> Enum.reduce([], &select_bests/2)
    |> Enum.map(fn {hand, _rank} -> hand end)
  end

  defp parse(hand) do
    rank = hand
    |> Enum.map(&parse_card/1)
    |> Enum.sort_by(fn {rank,_} -> rank end)
    |> Enum.reverse()
    |> rank()

    {hand, rank}
  end

  defp parse_card(str) do
    [rank, suit] = String.split(str, ~r{[CDHS]}, trim: true, include_captures: true)
    {parse_card_rank(rank), String.to_atom(suit)}
  end

  defp parse_card_rank("A"), do: 14
  defp parse_card_rank("K"), do: 13
  defp parse_card_rank("Q"), do: 12
  defp parse_card_rank("J"), do: 11
  defp parse_card_rank(str), do: String.to_integer(str)

  defp rank([{a,s},  {b,s},  {c,s},  {d,s},  {e,s}])
  when (b == a - 1) and c == b - 1 and d == c - 1 and e == d - 1 do
    {:straight_flush, [a, b, c, d, e]}
  end
  defp rank([{14,s},  {5,s},  {4,s},  {3,s},  {2,s}]), do: {:straight_flush, [5, 4, 3, 2, 1]}

  defp rank([{a,_},  {a,_},  {a,_},  {a,_},  {b,_}]), do: {:poker, [a, b]}
  defp rank([{b,_},  {a,_},  {a,_},  {a,_},  {a,_}]), do: {:poker, [a, b]}
  defp rank([{a,_},  {a,_},  {a,_},  {b,_},  {b,_}]), do: {:full_house, [a, b]}
  defp rank([{b,_},  {b,_},  {a,_},  {a,_},  {a,_}]), do: {:full_house, [a, b]}
  defp rank([{a,s},  {b,s},  {c,s},  {d,s},  {e,s}]), do: {:flush, [a, b, c, d, e]}
  defp rank([{a,_},  {b,_},  {c,_},  {d,_},  {e,_}])
  when (b == a - 1) and c == b - 1 and d == c - 1 and e == d - 1 do
    {:straight, [a, b, c, d, e]}
  end
  defp rank([{14,_},  {5,_},  {4,_},  {3,_},  {2,_}]), do: {:straight, [5, 4, 3, 2, 1]}
  defp rank([{a,_},  {a,_},  {a,_},  {b,_},  {c,_}]), do: {:tris, [a, b, c]}
  defp rank([{b,_},  {a,_},  {a,_},  {a,_},  {c,_}]), do: {:tris, [a, b, c]}
  defp rank([{b,_},  {c,_},  {a,_},  {a,_},  {a,_}]), do: {:tris, [a, b, c]}
  defp rank([{a,_},  {a,_},  {b,_},  {b,_},  {c,_}]), do: {:two_pair, [a, b, c]}
  defp rank([{c,_},  {a,_},  {a,_},  {b,_},  {b,_}]), do: {:two_pair, [a, b, c]}
  defp rank([{a,_},  {a,_},  {c,_},  {b,_},  {b,_}]), do: {:two_pair, [a, b, c]}
  defp rank([{a,_},  {a,_},  {b,_},  {c,_},  {d,_}]), do: {:pair, [a, b, c, d]}
  defp rank([{b,_},  {a,_},  {a,_},  {c,_},  {d,_}]), do: {:pair, [a, b, c, d]}
  defp rank([{b,_},  {c,_},  {a,_},  {a,_},  {d,_}]), do: {:pair, [a, b, c, d]}
  defp rank([{b,_},  {c,_},  {d,_},  {a,_},  {a,_}]), do: {:pair, [a, b, c, d]}
  defp rank([{a,_},  {b,_},  {c,_},  {d,_},  {e,_}]), do: {:highest, [a, b, c, d, e]}

  defp select_bests(hand, []) do
    [hand]
  end

  defp select_bests(current = {_hand, rank}, previous = [{_previous_hand, previous_rank} | _]) do
    cond do
      rank == previous_rank -> previous ++ [current]
      greather_than(rank, previous_rank) -> [current]
      true -> previous
    end
  end

  defp greather_than({rank, [eq | at]}, {rank, [eq | bt]}) do
    greather_than({rank, at}, {rank, bt})
  end

  defp greather_than({rank, [a | _at]}, {rank, [b | _bt]}) do
    a > b
  end

  defp greather_than({a_rank, [_ | _at]}, {b_rank, [_ | _bt]}) do
    to_sortable = fn (rank) ->
      case rank do
        :straight_flush -> 8
        :poker -> 7
        :full_house -> 6
        :flush -> 5
        :straight -> 4
        :tris -> 3
        :two_pair -> 2
        :pair -> 1
        :highest -> 0
      end
    end

    to_sortable.(a_rank) > to_sortable.(b_rank)
  end
end
