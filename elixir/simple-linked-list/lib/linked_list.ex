defmodule LinkedList do
  @opaque t :: tuple()

  defstruct elem: nil, tail: nil

  @doc """
  Construct a new LinkedList
  """
  @spec new() :: t
  def new(), do: %__MODULE__{}

  @doc """
  Push an item onto a LinkedList
  """
  @spec push(t, any()) :: t
  def push(list, elem), do: %LinkedList{elem: elem, tail: list}

  @doc """
  Calculate the length of a LinkedList
  """
  @spec length(t) :: non_neg_integer()
  def length(%LinkedList{elem: nil}), do: 0
  def length(%LinkedList{tail: tail}), do: 1 + LinkedList.length(tail)

  @doc """
  Determine if a LinkedList is empty
  """
  @spec empty?(t) :: boolean()
  def empty?(%LinkedList{elem: nil}), do: true
  def empty?(_), do: false

  @doc """
  Get the value of a head of the LinkedList
  """
  @spec peek(t) :: {:ok, any()} | {:error, :empty_list}
  def peek(%LinkedList{elem: nil}), do: {:error, :empty_list}
  def peek(%LinkedList{elem: elem}), do: {:ok, elem}

  @doc """
  Get tail of a LinkedList
  """
  @spec tail(t) :: {:ok, t} | {:error, :empty_list}
  def tail(%LinkedList{elem: nil}), do: {:error, :empty_list}
  def tail(%LinkedList{tail: t}), do: {:ok, t}

  @doc """
  Remove the head from a LinkedList
  """
  @spec pop(t) :: {:ok, any(), t} | {:error, :empty_list}
  def pop(%LinkedList{elem: nil}), do: {:error, :empty_list}
  def pop(%LinkedList{elem: e, tail: t}), do: {:ok, e, t}

  @doc """
  Construct a LinkedList from a stdlib List
  """
  @spec from_list(list()) :: t
  def from_list([]), do: LinkedList.new()
  def from_list([head | tail]), do: %LinkedList{elem: head, tail: from_list(tail)}

  @doc """
  Construct a stdlib List LinkedList from a LinkedList
  """
  @spec to_list(t) :: list()
  def to_list(%LinkedList{elem: nil}), do: []
  def to_list(%LinkedList{elem: e, tail: t}), do: [e | to_list(t)]

  @doc """
  Reverse a LinkedList
  """
  @spec reverse(t) :: t
  def reverse(list), do: do_reverse(list, %LinkedList{})

  defp do_reverse(%LinkedList{elem: nil}, acc), do: acc

  defp do_reverse(%LinkedList{elem: e, tail: t}, acc) do
    do_reverse(t, acc |> LinkedList.push(e))
  end
end
