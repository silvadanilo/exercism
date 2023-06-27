defmodule Grep do
  @option_line_number "-n"
  @option_file_name_only "-l"
  @option_case_insensitive "-i"
  @option_entire_line "-x"
  @option_inverted "-v"
  @option_add_file_name "-#"

  @spec grep(String.t(), [String.t()], [String.t()]) :: String.t()
  def grep(pattern, flags \\ [], files) do
    flags = if length(files) > 1, do: [@option_add_file_name | flags], else: flags
    flags = Enum.reduce(flags, %{}, fn x, acc -> Map.put(acc, x, true) end)
    pattern = build_pattern(pattern, flags)

    files
    |> Stream.map(fn file -> {file, grep_in_file(pattern, flags, file)} end)
    |> Stream.map(fn results -> format(results, flags) end)
    |> Enum.join("")
  end

  defp grep_in_file(pattern, flags, file) do
    filter_fn = if flags[@option_inverted], do: &Stream.reject/2, else: &Stream.filter/2

    file
    |> File.stream!()
    |> Stream.with_index(1)
    |> filter_fn.(fn {text, _line_number} -> String.match?(text, pattern) end)
    |> Enum.to_list()
  end

  defp build_pattern(pattern, flags) do
    regex_flags = if flags[@option_case_insensitive], do: "i", else: ""
    pattern = if flags[@option_entire_line], do: "^#{pattern}$", else: pattern
    Regex.compile!(pattern, regex_flags)
  end

  defp format({_file, []}, %{@option_file_name_only => true}), do: []
  defp format({file, _}, %{@option_file_name_only => true}), do: "#{file}\n"

  defp format({file, results}, flags) do
    Enum.map(results, fn {text, line_number} ->
      cond do
        flags[@option_add_file_name] && flags[@option_line_number] -> [file, line_number, text]
        flags[@option_add_file_name] -> [file, text]
        flags[@option_line_number] -> [line_number, text]
        true -> [text]
      end
      |> Enum.join(":")
    end)
  end
end
