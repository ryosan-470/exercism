defmodule RNATranscription do
  @doc """
  Transcribes a character list representing DNA nucleotides to RNA

  ## Examples

  iex> RNATranscription.to_rna('ACTG')
  'UGAC'
  """
  @spec to_rna([char]) :: [char]
  def to_rna(dna) when dna == [], do: []

  def to_rna(dna) do
    [hd | tl] = dna
    case hd do
      ?G -> 'C'
      ?C -> 'G'
      ?T -> 'A'
      ?A -> 'U'
    end ++ to_rna(tl)
  end
end
