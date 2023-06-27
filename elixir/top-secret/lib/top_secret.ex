defmodule TopSecret do
  def to_ast(string) do
    Code.string_to_quoted!(string)
  end

  def decode_secret_message_part({macro, _, args} = ast, acc) when macro in [:def, :defp] do
    IO.inspect(ast)
    {fn_name, args} = extract_fn_name_and_args(args)

    secret =
      fn_name
      |> Atom.to_string()
      |> String.slice(0, secret_message_length(args))

    {ast, [secret | acc]}
  end

  def decode_secret_message_part(ast, acc) do
    IO.inspect(ast)
    {ast, acc}
  end

  def decode_secret_message(string) do
    string
    |> to_ast()
    |> Macro.prewalk([], &decode_secret_message_part/2)
    |> elem(1)
    |> Enum.reverse()
    |> Enum.join("")
  end

  defp extract_fn_name_and_args([{:when, _, args} | _]), do: extract_fn_name_and_args(args)
  defp extract_fn_name_and_args([{fn_name, _, nil} | _]), do: {fn_name, []}
  defp extract_fn_name_and_args([{fn_name, _, args} | _]), do: {fn_name, args}

  defp secret_message_length(nil), do: 0
  defp secret_message_length(args), do: length(args)
end
