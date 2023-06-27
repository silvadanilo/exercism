defmodule BasketballWebsite do
  def extract_from_path(data, []), do: data
  def extract_from_path(data, [key | path]), do: extract_from_path(data[key], path)

  def extract_from_path(data, path) do
    path = String.split(path, ".")
    extract_from_path(data, path)
  end

  def get_in_path(data, path) do
    Kernel.get_in(data, String.split(path, "."))
  end
end
