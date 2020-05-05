defmodule BinarySearch do
  @doc """
    Searches for a key in the tuple using the binary search algorithm.
    It returns :not_found if the key is not in the tuple.
    Otherwise returns {:ok, index}.

    ## Examples

      iex> BinarySearch.search({}, 2)
      :not_found

      iex> BinarySearch.search({1, 3, 5}, 2)
      :not_found

      iex> BinarySearch.search({1, 3, 5}, 5)
      {:ok, 2}

  """

  @spec search(tuple, integer) :: {:ok, integer} | :not_found
  def search({}, _key), do: :not_found

  def search(numbers, key), do: do_search(numbers, key, 0, numbers |> tuple_size())

  def do_search(_numbers, _key, low, high) when high < low, do: :not_found

  def do_search(numbers, key, low, high) do
    mid = div(low + high, 2)

    elem(numbers, mid)
    |> case do
      ^key -> {:ok, mid}
      value when key < value -> do_search(numbers, key, low, mid - 1)
      value when key > value -> do_search(numbers, key, mid + 1, high)
    end
  rescue
    _ -> :not_found
  end
end
