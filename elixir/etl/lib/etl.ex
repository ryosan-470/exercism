defmodule ETL do
  @doc """
  Transform an index into an inverted index.

  ## Examples

  iex> ETL.transform(%{"a" => ["ABILITY", "AARDVARK"], "b" => ["BALLAST", "BEAUTY"]})
  %{"ability" => "a", "aardvark" => "a", "ballast" => "b", "beauty" =>"b"}
  """
  @spec transform(map) :: map
  def transform(input) do
    input
    |> Map.keys()
    |> Enum.map(fn k -> input[k] |> Enum.map(fn v -> {v |> String.downcase(), k} end) end)
    |> List.flatten()
    |> Map.new()
  end
end
