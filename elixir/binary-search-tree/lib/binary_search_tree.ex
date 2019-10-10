defmodule BinarySearchTree do
  @type bst_node :: %{data: any, left: bst_node | nil, right: bst_node | nil}

  @doc """
  Create a new Binary Search Tree with root's value as the given 'data'
  """
  @spec new(any) :: bst_node
  def new(data) do
    %{data: data, left: nil, right: nil}
  end

  @doc """
  Creates and inserts a node with its value as 'data' into the tree.
  """
  @spec insert(bst_node, any) :: bst_node
  def insert(tree = %{data: current, left: left}, data) when data <= current do
    %{tree | left: insert(left, data)}
  end

  def insert(tree = %{data: current, right: right}, data) when data > current do
    %{tree | right: insert(right, data)}
  end

  def insert(nil, data), do: new(data)

  @doc """
  Traverses the Binary Search Tree in order and returns a list of each node's data.
  """
  @spec in_order(bst_node) :: [any]
  def in_order(nil), do: []
  def in_order(%{data: d, left: l, right: r}) do
    in_order(l) ++ [d] ++ in_order(r)
  end
end
