defmodule ProteinTranslation do
  @doc """
  Given an RNA string, return a list of proteins specified by codons, in order.
  """
  @spec of_rna(String.t()) :: {atom, list(String.t())}
  def of_rna(rna) do
    lists =
      rna
      |> String.codepoints()
      |> Enum.chunk_every(3)
      |> Enum.map(fn r ->
        with {:ok, name} <- r |> Enum.join() |> of_codon() do
          name
        else
          {:error, _} -> {:error, "invalid RNA"}
        end
      end)

    if Enum.find(lists, &match?({:error, _}, &1)) do
      {:error, "invalid RNA"}
    else
      lists =
        Enum.reduce_while(lists, [], fn x, acc ->
          if x == "STOP" do
            {:halt, acc}
          else
            {:cont, [x | acc]}
          end
        end)
        |> Enum.reverse()

      {:ok, lists}
    end
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
  @spec of_codon(String.t()) :: {:ok, String.t()} | {:error, String.t()}
  def of_codon(codon) do
    case codon do
      c when c in ~w(UGU UGC) -> {:ok, "Cysteine"}
      c when c in ~w(UUA UUG) -> {:ok, "Leucine"}
      "AUG" -> {:ok, "Methionine"}
      c when c in ~w(UUU UUC) -> {:ok, "Phenylalanine"}
      c when c in ~W(UCU UCC UCA UCG) -> {:ok, "Serine"}
      "UGG" -> {:ok, "Tryptophan"}
      c when c in ~w(UAU UAC) -> {:ok, "Tyrosine"}
      c when c in ~W(UAA UAG UGA) -> {:ok, "STOP"}
      _ -> {:error, "invalid codon"}
    end
  end
end
