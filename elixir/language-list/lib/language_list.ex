defmodule LanguageList do
  def new(), do: []
  def add(list, language), do: [language | list]
  def remove([_head | list]), do: list
  def first([head | _list]), do: head
  def count(list), do: _count(list, 0) # Enum.count(list)
  def functional_list?(list), do: "Elixir" in list

  defp _count([], count), do: count
  defp _count([_ | list], count), do: _count(list, count + 1)
end
