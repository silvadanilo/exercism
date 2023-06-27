defmodule NameBadge do
  def print(id, name, department) do
    # use if just because it is required by exercism

    department = if department == nil, do: "OWNER", else: String.upcase(department)
    id_prefix = if id == nil, do: "", else: "[#{id}] - "
    id_prefix <> "#{name} - #{department}"
  end
end
