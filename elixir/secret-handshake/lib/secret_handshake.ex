use Bitwise

defmodule SecretHandshake do
  @doc """
  Determine the actions of a secret handshake based on the binary
  representation of the given `code`.

  If the following flags are set, include the corresponding action in your list
  of commands, in order from lowest to highest.

  1 = wink
  10 = double blink
  100 = close your eyes
  1000 = jump

  10000 = Reverse the order of the operations in the secret handshake
  """
  @actions [
    {0b1, "wink"},
    {0b10, "double blink"},
    {0b100, "close your eyes"},
    {0b1000, "jump"},
    {0b10000, &Enum.reverse/1}
  ]

  @spec commands(code :: integer) :: list(String.t())
  def commands(code) do
    @actions
    |> Enum.filter(fn {flag, _action} ->
      (code &&& flag) == flag
    end)
    |> Enum.reduce([], fn {_flag, action}, acc ->
      do_command(acc, action)
    end)
  end

  defp do_command(acc, v) when is_binary(v), do: acc ++ [v]

  defp do_command(acc, v) when is_function(v), do: v.(acc)
end
