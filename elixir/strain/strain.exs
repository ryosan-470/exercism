defmodule Strain do
  @doc """
  Given a `list` of items and a function `fun`, return the list of items where
  `fun` returns true.

  Do not use `Enum.filter`.
  """
  @spec keep(list :: list(any), fun :: (any -> boolean)) :: list(any)
  def keep(list, fun), do: do_loop(list, true, [], fun)

  @doc """
  Given a `list` of items and a function `fun`, return the list of items where
  `fun` returns false.

  Do not use `Enum.reject`.
  """
  @spec discard(list :: list(any), fun :: (any -> boolean)) :: list(any)
  def discard(list, fun), do: do_loop(list, false, [], fun)

  defp do_loop([], _bool, acc, _fun), do: acc |> Enum.reverse()

  defp do_loop([head | tail], bool, acc, fun) do
    if apply(fun, [head]) == bool do
      do_loop(tail, bool, [head | acc], fun)
    else
      do_loop(tail, bool, acc, fun)
    end
  end
end
