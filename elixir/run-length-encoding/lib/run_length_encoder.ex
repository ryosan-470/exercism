defmodule RunLengthEncoder do
  @doc """
  Generates a string where consecutive elements are represented as a data value and count.
  "AABBBCCCC" => "2A3B4C"
  For this example, assume all input are strings, that are all uppercase letters.
  It should also be able to reconstruct the data into its original form.
  "2A3B4C" => "AABBBCCCC"
  """
  @spec encode(String.t()) :: String.t()
  def encode(string) do
    string
    |> String.codepoints()
    |> Enum.reduce([], fn x, acc ->
      with [{c, cnt} | tail] <- acc,
           true <- x == c do
        [{x, cnt + 1} | tail]
      else
        _ -> [{x, 1} | acc]
      end
    end)
    |> Enum.reverse()
    |> Enum.map_join(fn {x, c} ->
      if c == 1 do
        x
      else
        "#{c}#{x}"
      end
    end)
  end

  @spec decode(String.t()) :: String.t()
  def decode(string) do
    string
    |> String.codepoints()
    |> do_decode([], "")
  end

  defp do_decode([], [], result), do: result

  defp do_decode([h | rest], acc, result) do
    if numeric?(h) do
      do_decode(rest, [h | acc], result)
    else
      if Enum.empty?(acc) do
        do_decode(rest, [], "#{result}#{h}")
      else
        count = acc |> Enum.reverse() |> Enum.join() |> String.to_integer()
        do_decode(rest, [], "#{result}#{String.duplicate(h, count)}")
      end
    end
  end

  defp numeric?(c), do: c in ~w(1 2 3 4 5 6 7 8 9 0)
end
