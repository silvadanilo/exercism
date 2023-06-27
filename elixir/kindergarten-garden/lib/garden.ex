defmodule Garden do
  @plants %{
    "C" => :clover,
    "G" => :grass,
    "R" => :radishes,
    "V" => :violets
  }

  @default_student_names ~w[alice bob charlie david eve fred ginny harriet ileana joseph kincaid larry]a

  @doc """
    Accepts a string representing the arrangement of cups on a windowsill and a
    list with names of students in the class. The student names list does not
    have to be in alphabetical order.

    It decodes that string into the various gardens for each student and returns
    that information in a map.
  """
  @spec info(String.t(), list) :: map
  def info(info_string, student_names \\ @default_student_names) do
    student_names = Enum.sort(student_names)
    student_plants = for student <- student_names, into: %{}, do: {student, {}}

    info_string
    |> String.split("\n")
    |> Enum.map(&decode/1)
    |> Enum.zip()
    |> Enum.chunk_every(2)
    |> Enum.zip(student_names)
    |> Enum.reduce(student_plants, fn {[{a, c}, {b, d}], student}, acc ->
      Map.put(acc, student, {a, b, c, d})
    end)
  end

  defp decode(encoded_plants) do
    encoded_plants
    |> String.graphemes()
    |> Enum.map(&@plants[&1])
  end
end
