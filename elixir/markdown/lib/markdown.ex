defmodule Markdown do
  @doc """
    Parses a given string with Markdown syntax and returns the associated HTML for that string.

    ## Examples

    iex> Markdown.parse("This is a paragraph")
    "<p>This is a paragraph</p>"

    iex> Markdown.parse("#Header!\n* __Bold Item__\n* _Italic Item_")
    "<h1>Header!</h1><ul><li><em>Bold Item</em></li><li><i>Italic Item</i></li></ul>"
  """
  # Using pipeline
  # renamed vars
  @spec parse(String.t()) :: String.t()
  def parse(markdown_text) do
    markdown_text
    |> String.split("\n")
    |> Enum.map(fn line -> process(line) end)
    |> Enum.join()
    |> patch()
  end

  # Removed if in favor of pattern matching on first char of a line
  # Used pipe
  defp process(line = "#" <> _) do
    line
    |> parse_header_md_level()
    |> enclose_with_header_tag()
  end

  # Removed if in favor of pattern matching on first char of a line
  defp process(line = "*" <> _) do
    parse_list_md_level(line)
  end

  # Removed if in favor of pattern matching on first char of a line
  # Used pipe
  defp process(line) do
    line
    |> String.split()
    |> enclose_with_paragraph_tag()
  end

  defp parse_header_md_level(hwt) do
    [h | t] = String.split(hwt)
    {
      to_string(String.length(h)),
      Enum.join(t, " ")
    }
  end

  defp parse_list_md_level(l) do
    t = String.split(String.trim_leading(l, "* "))
    "<li>" <> join_words_with_tags(t) <> "</li>"
  end

  # used string interpolation
  defp enclose_with_header_tag({level, text}) do
    "<h#{level}>#{text}</h#{level}>"
  end

  defp enclose_with_paragraph_tag(words) do
    "<p>#{join_words_with_tags(words)}</p>"
  end

  defp join_words_with_tags(words) do
    words
    |> Enum.map(fn w -> replace_md_with_tag(w) end)
    |> Enum.join(" ")
  end

  # Used pipe
  defp replace_md_with_tag(word) do
    word
    |> replace_prefix_md()
    |> replace_suffix_md()
  end

  defp replace_prefix_md(w) do
    cond do
      w =~ ~r/^#{"__"}{1}/ -> String.replace(w, ~r/^#{"__"}{1}/, "<strong>", global: false)
      w =~ ~r/^[#{"_"}{1}][^#{"_"}+]/ -> String.replace(w, ~r/_/, "<em>", global: false)
      true -> w
    end
  end

  defp replace_suffix_md(w) do
    cond do
      w =~ ~r/#{"__"}{1}$/ -> String.replace(w, ~r/#{"__"}{1}$/, "</strong>")
      w =~ ~r/[^#{"_"}{1}]/ -> String.replace(w, ~r/_/, "</em>")
      true -> w
    end
  end

  defp patch(html_lists) do
    html_lists
    |> String.replace("<li>", "<ul><li>", global: false)
    |> String.replace_suffix("</li>", "</li></ul>")
  end
end
