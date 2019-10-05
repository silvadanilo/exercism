defmodule PigLatin do
  @doc """
  Given a `phrase`, translate it a word at a time to Pig Latin.

  Words beginning with consonants should have the consonant moved to the end of
  the word, followed by "ay".

  Words beginning with vowels (aeiou) should have "ay" added to the end of the
  word.

  Some groups of letters are treated like consonants, including "ch", "qu",
  "squ", "th", "thr", and "sch".

  Some groups are treated like vowels, including "yt" and "xr".
  """
  @spec translate(phrase :: String.t()) :: String.t()
  def translate(phrase) do
    phrase
    |> String.split(" ")
    |> Enum.map(&do_translate/1)
    |> Enum.join(" ")
  end

  defp do_translate(phrase) do
    rules = %{
      :begin_with_vowel_sound => %{
        :match => ~r{^([aeiou]|xr|xb|yt|yd)},
        :replace_pattern => ~r{(.*)()},
      },

      :starts_with_a_consonant_sound_followed_by_qu => %{
        :match => ~r{^[^aeiou]?qu},
        :replace_pattern => ~r{(.*qu)(.*)},
      },

      :contains_a_y_after_a_consonant_cluster => %{
        :match => ~r{^[^aeiouy]+y},
        :replace_pattern => ~r{([^aeiouy]+)(y.*)},
      },

      :starts_with_consonant_sound => %{
        :match => ~r{^[^aeiou]},
        :replace_pattern => ~r/([^aeiou]+)(.*)/,
      },
    }

    {_, rule} = Enum.find(rules, fn {_, rule} ->
      Regex.match?(rule[:match], phrase)
    end)

    Regex.replace(rule[:replace_pattern], phrase, "\\2\\1ay", global: false)
  end

  ###
  # ALTERNATIVE VERSION
  ###
  # defp do_translate(phrase) do
  #   cond do
  #     begin_with_vowel_sound(phrase) ->
  #       phrase <> "ay"
  #     starts_with_a_consonant_sound_followed_by_qu(phrase) ->
  #       Regex.replace(~r/(.*qu)(.*)/, phrase, "\\2\\1ay")
  #     contains_a_y_after_a_consonant_cluster(phrase) ->
  #       Regex.replace(~r/([^aeiouy]+)(y.*)/, phrase, "\\2\\1ay")
  #     starts_with_consonant_sound(phrase) ->
  #       Regex.replace(~r/([^aeiou]+)(.*)/, phrase, "\\2\\1ay")
  #   end
  # end
  # defp begin_with_vowel_sound(phrase) do
  #   Regex.match?(~r{^([aeiou]|xr|xb|yt|yd)}, phrase)
  # end

  # defp starts_with_a_consonant_sound_followed_by_qu(phrase) do
  #     Regex.match?(~r{^[^aeiou]?qu}, phrase)
  # end

  # defp contains_a_y_after_a_consonant_cluster(phrase) do
  #   Regex.match?(~r{^[^aeiouy]+y}, phrase)
  # end

  # defp starts_with_consonant_sound(phrase) do
  #   Regex.match?(~r{^[^aeiou]}, phrase)
  # end
end
