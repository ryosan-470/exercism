defmodule ListOps do
  # Please don't use any external modules (especially List or Enum) in your
  # implementation. The point of this exercise is to create these basic
  # functions yourself. You may use basic Kernel functions (like `Kernel.+/2`
  # for adding numbers), but please do not use Kernel functions for Lists like
  # `++`, `--`, `hd`, `tl`, `in`, and `length`.

  @spec count(list) :: non_neg_integer
  def count([]), do: 0
  def count([_head | tail]), do: 1 + count(tail)

  @spec reverse(list) :: list
  def reverse(list), do: do_reverse(list, [])

  defp do_reverse([], acc), do: acc

  defp do_reverse([head | tail], acc) do
    do_reverse(tail, [head | acc])
  end

  @spec map(list, (any -> any)) :: list
  def map(l, f), do: do_map(l, [], f)

  defp do_map([], acc, _f), do: reverse(acc)

  defp do_map([head | tail], acc, f) do
    do_map(tail, [apply(f, [head]) | acc], f)
  end

  @spec filter(list, (any -> as_boolean(term))) :: list
  def filter(l, f), do: do_filter(l, [], f)

  defp do_filter([], acc, _f), do: reverse(acc)

  defp do_filter([head | tail], acc, f) do
    if apply(f, [head]) do
      do_filter(tail, [head | acc], f)
    else
      do_filter(tail, acc, f)
    end
  end

  @type acc :: any
  @spec reduce(list, acc, (any, acc -> acc)) :: acc
  def reduce([], acc, _f), do: acc

  def reduce([head | tail], acc, f) do
    reduce(tail, apply(f, [head, acc]), f)
  end

  @spec append(list, list) :: list
  def append([], b), do: b
  def append([head | tail], l), do: [head | append(tail, l)]

  @spec concat([[any]]) :: [any]
  def concat([]), do: []
  def concat([head | tail]), do: append(head, concat(tail))
end
