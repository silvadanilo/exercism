defmodule RunLengthEncoder do
  @doc """
  Generates a string where consecutive elements are represented as a data value and count.
  "AABBBCCCC" => "2A3B4C"
  For this example, assume all input are strings, that are all uppercase letters.
  It should also be able to reconstruct the data into its original form.
  "2A3B4C" => "AABBBCCCC"
  """
  @spec encode(String.t()) :: String.t()
  def encode(string) do
    string
    |> String.codepoints()
    |> Enum.chunk_by(&(&1))
    |> Enum.map(&compress/1)
    |> Enum.join()
  end

  defp compress([char]) do
    char
  end

  defp compress(char_list) do
    "#{length(char_list)}#{List.first(char_list)}"
  end

  @spec decode(String.t()) :: String.t()
  def decode(string) do
    Regex.scan(~r{(\d*)(.)}, string)
    |> Enum.map(&decompress/1)
    |> Enum.join()
  end

  defp decompress([_, "", char]) do
    char
  end

  defp decompress([_, count, char]) do
    String.duplicate(char, String.to_integer(count))
  end

  #################################################
  # BETTER ALTERNATIVE VERSION BUT TOO EASY
  #################################################
  # def encode(string) do
  #   Regex.replace ~r/(.)\1*/, string, &encode(String.length(&1), &2)
  # end

  # def encode(1, char) do
  #   char
  # end

  # def encode(count, char) do
  #   "#{count}#{char}"
  # end

  # def decode(string) do
  #   Regex.replace(~r/(\d+)(.)/, string, fn _, len, char ->
  #     String.duplicate(char, String.to_integer(len))
  #   end)
  # end
end
