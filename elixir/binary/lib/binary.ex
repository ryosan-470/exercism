defmodule Binary do
  @doc """
  Convert a string containing a binary number to an integer.

  On errors returns 0.
  """
  @spec to_decimal(String.t()) :: non_neg_integer
  def to_decimal(string) do
    with true <- string |> String.codepoints() |> Enum.all?(&(&1 in ~w(0 1))) do
      string
      |> String.codepoints()
      |> Enum.reverse()
      |> Enum.with_index()
      |> Enum.map(fn {base, exp} ->
        (String.to_integer(base) * :math.pow(2, exp)) |> round()
      end)
      |> Enum.sum()
    else
      false -> 0
    end
  end
end
