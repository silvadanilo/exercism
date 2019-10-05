################################
### Without Using elixir modules
################################
defmodule Sublist do
  @doc """
  Returns whether the first list is a sublist or a superlist of the second list
  and if not whether it is equal or unequal to the second list.
  """
  def compare(a, b) when a === b, do: :equal

  def compare(a, b) do
    cond do
      is_a_sublist a, b -> :sublist
      is_a_sublist b, a -> :superlist
      true -> :unequal
    end
  end

  defp is_a_sublist(a, b) when length(a) > length(b), do: false

  defp is_a_sublist(a, b = [_ | tb]) do
    case do_is_a_sublist(a, b) do
      true -> true
      false -> is_a_sublist(a, tb)
    end
  end

  defp do_is_a_sublist(a, b) when length(a) > length(b), do: false

  defp do_is_a_sublist([], _), do: true

  # two heads are equals
  defp do_is_a_sublist([equal | ta], [equal | tb]) do
    do_is_a_sublist(ta, tb)
  end

  defp do_is_a_sublist(_, _), do: false
end


################################
### Using elixir modules
################################
# defmodule Sublist do
#   @doc """
#   Returns whether the first list is a sublist or a superlist of the second list
#   and if not whether it is equal or unequal to the second list.
#   """
#   def compare(a, b) when a === b, do: :equal

#   def compare([], _), do: :sublist
#   def compare(_, []), do: :superlist

#   def compare(a, b) when length(a) < length(b) do
#     if is_a_sublist a, b do
#       :sublist
#     else
#       :unequal
#     end
#   end

#   def compare(a, b) when length(a) > length(b) do
#     if is_a_sublist b, a do
#       :superlist
#     else
#       :unequal
#     end
#   end

#   def compare(_, _), do: :unequal

#   defp is_a_sublist(a, b) when length(a) > length(b), do: false

#   defp is_a_sublist(a, b) do
#     length_a = length(a)
#     nil !==  b
#     |> Stream.chunk_every(length_a, 1, :discard)
#     |> Enum.find(&(&1 === a))
#   end
# end
