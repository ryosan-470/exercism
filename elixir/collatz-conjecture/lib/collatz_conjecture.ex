defmodule CollatzConjecture do
  @doc """
  calc/1 takes an integer and returns the number of steps required to get the
  number to 1 when following the rules:
    - if number is odd, multiply with 3 and add 1
    - if number is even, divide by 2
  """
  @spec calc(input :: pos_integer()) :: non_neg_integer()
  def calc(input) when is_integer(input) and input > 0, do: do_calc(input, 0)
  def calc(_input), do: raise(FunctionClauseError)

  defp do_calc(1, c), do: c
  defp do_calc(n, c) when rem(n, 2) == 0, do: div(n, 2) |> do_calc(c + 1)
  defp do_calc(n, c), do: do_calc(n * 3 + 1, c + 1)
end
