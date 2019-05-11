defmodule Words do
  @doc """
  Count the number of words in the sentence.

  Words are compared case-insensitively.
  """
  @spec count(String.t()) :: map
  def count(sentence) do
    sentence
    |> normalize()
    |> Enum.reduce(%{}, fn x, map -> Map.update(map, x, 1, &(&1 + 1)) end)
  end

  @spec normalize(String.t()) :: list()
  defp normalize(sentence) do
    Regex.replace(~r/[:!&@$%^.,]/, sentence |> String.downcase(), "")
    |> String.replace("_", " ")
    |> String.split()
  end
end
