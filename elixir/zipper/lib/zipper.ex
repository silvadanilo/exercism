defmodule Zipper do
  defstruct focus: nil, events: []

  @doc """
  Get a zipper focused on the root node.
  """
  @spec from_tree(BinTree.t()) :: Zipper.t()
  def from_tree(bin_tree) do
    %Zipper{focus: bin_tree, events: []}
  end

  @doc """
  Get the complete tree from a zipper.
  """
  @spec to_tree(Zipper.t()) :: BinTree.t()
  def to_tree(%{events: events, focus: focus}) do
    Enum.reduce(events, focus, fn {action, node}, acc ->
      case action do
        :left -> %{node | left: acc}
        :right -> %{node | right: acc}
      end
    end)
  end

  @doc """
  Get the value of the focus node.
  """
  @spec value(Zipper.t()) :: any
  def value(%{focus: focus}) do
    focus.value
  end

  @doc """
  Get the left child of the focus node, if any.
  """
  @spec left(Zipper.t()) :: Zipper.t() | nil
  def left(%{focus: %{left: nil}}), do: nil

  def left(zipper) do
    focus = zipper.focus.left
    event = {:left, %{zipper.focus | left: nil}}
    %{zipper | focus: focus, events: [event | zipper.events]}
  end

  @doc """
  Get the right child of the focus node, if any.
  """
  @spec right(Zipper.t()) :: Zipper.t() | nil
  def right(%{focus: %{right: nil}}), do: nil

  def right(zipper) do
    focus = zipper.focus.right
    event = {:right, %{zipper.focus | right: nil}}
    %{zipper | focus: focus, events: [event | zipper.events]}
  end

  @doc """
  Get the parent of the focus node, if any.
  """
  @spec up(Zipper.t()) :: Zipper.t() | nil
  def up(%{events: []}), do: nil

  def up(zipper = %{events: [last_event | other_events]}) do
    focus =
      case last_event do
        {:left, node} -> %{node | left: zipper.focus}
        {:right, node} -> %{node | right: zipper.focus}
      end

    %{zipper | focus: focus, events: other_events}
  end

  @doc """
  Set the value of the focus node.
  """
  @spec set_value(Zipper.t(), any) :: Zipper.t()
  def set_value(zipper = %{focus: focus}, value) do
    focus = %{focus | value: value}
    %{zipper | focus: focus}
  end

  @doc """
  Replace the left child tree of the focus node.
  """
  @spec set_left(Zipper.t(), BinTree.t() | nil) :: Zipper.t()
  def set_left(zipper = %{focus: focus}, left) do
    focus = %{focus | left: left}
    %{zipper | focus: focus}
  end

  @doc """
  Replace the right child tree of the focus node.
  """
  @spec set_right(Zipper.t(), BinTree.t() | nil) :: Zipper.t()
  def set_right(zipper = %{focus: focus}, right) do
    focus = %{focus | right: right}
    %{zipper | focus: focus}
  end
end
