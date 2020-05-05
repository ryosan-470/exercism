defmodule BinarySearchTree do
  @type bst_node :: %{data: any, left: bst_node | nil, right: bst_node | nil}

  defstruct [:data, :left, :right]

  @doc """
  Create a new Binary Search Tree with root's value as the given 'data'
  """
  @spec new(any) :: bst_node
  def new(data) do
    %BinarySearchTree{data: data, left: nil, right: nil}
  end

  @doc """
  Creates and inserts a node with its value as 'data' into the tree.
  """
  @spec insert(bst_node, any) :: bst_node
  def insert(%{data: root, left: left} = tree, data) when root >= data do
    %{tree | left: left |> insert(data)}
  end

  def insert(%{data: root, right: right} = tree, data) when root < data do
    %{tree | right: right |> insert(data)}
  end

  def insert(nil, data), do: new(data)

  @doc """
  Traverses the Binary Search Tree in order and returns a list of each node's data.
  """
  @spec in_order(bst_node) :: [any]
  def in_order(%{data: d, left: left, right: right}) do
    [in_order(left), d, in_order(right)] |> List.flatten() |> Enum.reject(&is_nil/1)
  end

  def in_order(%{data: d, left: nil, right: nil}), do: d
  def in_order(nil), do: nil
end
