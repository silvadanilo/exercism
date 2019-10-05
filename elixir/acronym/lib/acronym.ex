defmodule Acronym do
  @doc """
  Generate an acronym from a string.
  "This is a string" => "TIAS"
  """
  @spec abbreviate(String.t()) :: String.t()
  def abbreviate(string) do
    string
    |> preprocess()
    |> String.split(" ", trim: true)
    |> Enum.map_join("", &String.first/1)
    |> String.upcase()
  end

  defp preprocess(string) do
    string
    |> String.replace(~r{([A-Z])}, " \\1")
  end
end
