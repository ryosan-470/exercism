defmodule ISBNVerifier do
  @doc """
    Checks if a string is a valid ISBN-10 identifier

    ## Examples

      iex> ISBNVerifier.isbn?("3-598-21507-X")
      true

      iex> ISBNVerifier.isbn?("3-598-2K507-0")
      false

  """
  @spec isbn?(String.t()) :: boolean
  def isbn?(isbn) do
    numbered =
      isbn
      |> String.replace("-", "")

    if Regex.match?(~r/[0-9]{9}[0-9X]{1}/, numbered) do
      numbered
      |> String.graphemes()
      # TODO: 末尾の X を 10 に変換したリストにする
      |> Enum.map(&(&1 |> String.to_integer()))
      |> Enum.reverse()
      |> Enum.with_index(1)
      |> Enum.reduce(0, fn {x, i}, acc -> x * i + acc end)
      |> rem(11) == 0
    else
      false
    end
  end
end
