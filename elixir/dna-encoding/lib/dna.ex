defmodule DNA do
  def encode_nucleotide(code_point) do
    case code_point do
      ?\s -> 0b0000
      ?A -> 0b0001
      ?C -> 0b0010
      ?G -> 0b0100
      ?T -> 0b1000
    end
  end

  def decode_nucleotide(encoded_code) do
    case encoded_code do
      0b0000 -> ?\s
      0b0001 -> ?A
      0b0010 -> ?C
      0b0100 -> ?G
      0b1000 -> ?T
    end
  end

  def encode(dna), do: do_encode(dna, <<>>)
  def decode(dna), do: dna |> do_decode([]) |> Enum.reverse()

  defp do_encode([], encoded), do: encoded

  defp do_encode([code_point | dna], encoded) do
    do_encode(dna, <<encoded::bitstring, encode_nucleotide(code_point)::size(4)>>)
  end

  defp do_decode(<<0::0>>, decoded), do: decoded

  defp do_decode(<<nucleotide::4, encoded::bitstring>>, decoded) do
    # adding to the head + reverse is more efficient than adding at the end
    do_decode(encoded, [decode_nucleotide(nucleotide) | decoded])
  end
end
