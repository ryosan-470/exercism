defmodule Scrabble do
  @doc """
  Calculate the scrabble score for the word.
  """
  @table %{
    "D" => 2,
    "G" => 2,
    "B" => 3,
    "C" => 3,
    "M" => 3,
    "P" => 3,
    "F" => 4,
    "H" => 4,
    "V" => 4,
    "W" => 4,
    "Y" => 4,
    "K" => 5,
    "J" => 8,
    "X" => 8,
    "Q" => 10,
    "Z" => 10,
    "" => 0
  }

  @spec score(String.t()) :: non_neg_integer
  def score(word) do
    Regex.replace(~r/[\t\n ]/, word, "")
    |> String.upcase()
    |> String.codepoints()
    |> Enum.reduce(0, fn x, sum ->
      if Map.has_key?(@table, x) do
        sum + @table[x]
      else
        sum + 1
      end
    end)
  end
end
