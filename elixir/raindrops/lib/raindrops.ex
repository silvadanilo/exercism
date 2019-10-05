defmodule Raindrops do
  @doc """
  Returns a string based on raindrop factors.

  - If the number contains 3 as a prime factor, output 'Pling'.
  - If the number contains 5 as a prime factor, output 'Plang'.
  - If the number contains 7 as a prime factor, output 'Plong'.
  - If the number does not contain 3, 5, or 7 as a prime factor,
    just pass the number's digits straight through.
  """
  @rules [{3, "Pling"}, {5, "Plang"}, {7, "Plong"}]

  @spec convert(pos_integer) :: String.t()
  def convert(number) do
    @rules
    |> Enum.map(&get_output_in_case_of_factor(&1, number))
    |> Enum.join()
    |> or_default(number)
  end

  defp get_output_in_case_of_factor({factor, output}, number) do
    if rem(number, factor) === 0, do: output
  end

  defp or_default("", number) do
    Integer.to_string(number)
  end

  defp or_default(output, _number) do
    output
  end


  #######################
  # ALTERNATIVE VERSION
  #######################
  # def convert(number) do
  #   process(number, "", @rules)
  # end

  # defp process(number, "", []) do
  #   Integer.to_string(number)
  # end

  # defp process(_number, acc, []), do: acc

  # defp process(number, acc, [{prime_factor, output} | rules]) do
  #   acc = if rem(number, prime_factor) === 0, do: acc <> output, else: acc
  #   process(number, acc, rules)
  # end
end
