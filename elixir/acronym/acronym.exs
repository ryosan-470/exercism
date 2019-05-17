defmodule Acronym do
  @doc """
  Generate an acronym from a string.
  "This is a string" => "TIAS"
  """
  @spec abbreviate(String.t()) :: String.t()
  def abbreviate(string) do
    string
    |> String.split()
    |> Enum.map(&capitalize_first(&1))
    |> Enum.map(&Regex.scan(~r/[A-Z]/, &1))
    |> List.flatten()
    |> Enum.join()
  end

  # 文字列の先頭文字だけを大文字に変換する
  defp capitalize_first(str) do
    first = str |> String.first() |> String.capitalize()
    first <> String.slice(str, 1, String.length(str) - 1)
  end
end
