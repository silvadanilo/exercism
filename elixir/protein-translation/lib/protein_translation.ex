defmodule ProteinTranslation do
  @stop_codon "STOP"
  @proteins %{
    "UGU" => "Cysteine",
    "UGC" => "Cysteine",
    "UUA" => "Leucine",
    "UUG" => "Leucine",
    "AUG" => "Methionine",
    "UUU" => "Phenylalanine",
    "UUC" => "Phenylalanine",
    "UCU" => "Serine",
    "UCC" => "Serine",
    "UCA" => "Serine",
    "UCG" => "Serine",
    "UGG" => "Tryptophan",
    "UAU" => "Tyrosine",
    "UAC" => "Tyrosine",
    "UAA" => @stop_codon,
    "UAG" => @stop_codon,
    "UGA" => @stop_codon,
  }

  @codons Map.keys(@proteins)


  @doc """
  Given an RNA string, return a list of proteins specified by codons, in order.
  """
  @spec of_rna(String.t()) :: {atom, list(String.t())}
  def of_rna(rna) do
    rna
    |> split_in_codons()
    |> convert_condosn_in_proteins()
    |> wrap_result([])
  end

  defp split_in_codons(rna) do
    rna
    |> Stream.unfold(&String.split_at(&1, 3))
    |> Enum.take_while(&(&1 != ""))
  end

  defp convert_condosn_in_proteins(codons_list) do
    codons_list
    |> Enum.map(&of_codon/1)
  end

  defp wrap_result([], acc) do
    {:ok, Enum.reverse(acc)}
  end

  defp wrap_result([{:ok, @stop_codon} | _], acc) do
    wrap_result([], acc)
  end

  defp wrap_result([{:ok, protein} | t], acc) do
    wrap_result(t, [protein | acc])
  end

  defp wrap_result([{:error, _} | _], _) do
    {:error, "invalid RNA"}
  end

  @doc """
  Given a codon, return the corresponding protein

  UGU -> Cysteine
  UGC -> Cysteine
  UUA -> Leucine
  UUG -> Leucine
  AUG -> Methionine
  UUU -> Phenylalanine
  UUC -> Phenylalanine
  UCU -> Serine
  UCC -> Serine
  UCA -> Serine
  UCG -> Serine
  UGG -> Tryptophan
  UAU -> Tyrosine
  UAC -> Tyrosine
  UAA -> STOP
  UAG -> STOP
  UGA -> STOP
  """
  @spec of_codon(String.t()) :: {atom, String.t()}
  def of_codon(codon) when codon in @codons, do: {:ok, @proteins[codon]}
  def of_codon(_), do: {:error, "invalid codon"}
end
