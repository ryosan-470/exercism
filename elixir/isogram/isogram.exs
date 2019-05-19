defmodule Isogram do
  @doc """
  Determines if a word or sentence is an isogram
  """
  @spec isogram?(String.t()) :: boolean
  def isogram?(sentence) do
    Regex.replace(~r/[- ]/, sentence, "")
    |> String.codepoints()
    |> Enum.reduce(
      %{},
      fn c, map ->
        if Map.has_key?(map, c) do
          %{map | c => map[c] + 1}
        else
          map |> Map.merge(%{c => 1})
        end
      end
    )
    |> Map.values()
    |> Enum.all?(&(&1 == 1))
  end
end
