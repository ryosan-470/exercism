defmodule Pangram do
  @doc """
  Determines if a word or sentence is a pangram.
  A pangram is a sentence using every letter of the alphabet at least once.

  Returns a boolean.

    ## Examples

      iex> Pangram.pangram?("the quick brown fox jumps over the lazy dog")
      true

  """
  @dicts ?a..?z |> Enum.map(&{List.to_string([&1]), 0}) |> Map.new()

  @spec pangram?(String.t()) :: boolean
  def pangram?(sentence) do
    sentence
    |> String.downcase()
    |> String.codepoints()
    |> Enum.reduce(@dicts, fn x, d ->
      if Map.get(d, x) do
        %{d | x => Map.get(d, x) + 1}
      else
        d
      end
    end)
    |> Map.values()
    |> Enum.all?(&(&1 > 0))
  end
end
