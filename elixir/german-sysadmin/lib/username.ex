defmodule Username do
  def sanitize(username) do
    Enum.reduce(username, '', fn c, acc ->
      acc ++
        case c do
          ?ä -> 'ae'
          ?ö -> 'oe'
          ?ü -> 'ue'
          ?ß -> 'ss'
          ?_ -> '_'
          c when c >= ?a and c <= ?z -> [c]
          _ -> ''
        end
    end)
  end
end
