defmodule Anagram do
  @doc """
  Returns all candidates that are anagrams of, but not equal to, 'base'.
  """
  @spec match(String.t(), [String.t()]) :: [String.t()]
  def match(base, candidates) do
    candidates
    |> Enum.map(&String.downcase/1)
    |> Enum.with_index()
    |> Enum.reject(fn {x, _c} -> x == String.downcase(base) end)
    |> Enum.map(fn {x, c} ->
      if to_map(x) == to_map(base), do: candidates |> Enum.at(c)
    end)
    |> Enum.reject(&is_nil/1)
  end

  def to_map(s) do
    s
    |> String.downcase()
    |> String.codepoints()
    |> Enum.reduce(%{}, fn x, acc ->
      acc
      |> Map.fetch(x)
      |> case do
        {:ok, d} -> %{acc | x => d + 1}
        :error -> acc |> Map.merge(%{x => 1})
      end
    end)
  end
end
