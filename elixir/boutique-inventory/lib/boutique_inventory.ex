defmodule BoutiqueInventory do
  def sort_by_price(inventory) do
    Enum.sort_by(inventory, fn item -> item.price end)
  end

  def with_missing_price(inventory) do
    Enum.filter(inventory, &(&1.price == nil))
  end

  def update_names(inventory, old_word, new_word) do
    Enum.map(inventory, fn item ->
      %{item | name: String.replace(item.name, old_word, new_word)}
    end)
  end

  def increase_quantity(item, count) do
    Map.update(item, :quantity_by_size, %{}, fn quantities ->
      Map.new(quantities, fn {k, v} -> {k, v + count} end)
    end)
  end

  def total_quantity(%{quantity_by_size: quantity_by_size} = _item) do
    Enum.reduce(quantity_by_size, 0, fn {_, quantity}, total -> total + quantity end)
  end
end
