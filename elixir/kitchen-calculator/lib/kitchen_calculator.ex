defmodule KitchenCalculator do
  @conversion_map %{
    cup: 240,
    fluid_ounce: 30,
    teaspoon: 5,
    tablespoon: 15
  }

  def get_volume({_unit, volume}), do: volume

  def to_milliliter({:milliliter, _} = milliliter), do: milliliter
  def to_milliliter({unit, volume}), do: {:milliliter, volume * @conversion_map[unit]}

  def from_milliliter(volume_pair, :milliliter), do: volume_pair
  def from_milliliter(volume_pair, unit), do: {unit, get_volume(volume_pair) / @conversion_map[unit]}

  def convert(volume_pair, unit) do
    volume_pair
    |> to_milliliter()
    |> from_milliliter(unit)
  end
end
