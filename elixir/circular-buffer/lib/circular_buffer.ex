defmodule CircularBuffer do
  @moduledoc """
  An API to a stateful process that fills and empties a circular buffer
  """

  defstruct elements: [], capacity: 0

  @doc """
  Create a new buffer of a given capacity
  """
  @spec new(capacity :: integer) :: {:ok, pid}
  def new(capacity) do
    Agent.start_link(fn -> %__MODULE__{elements: [], capacity: capacity} end)
  end

  @doc """
  Read the oldest entry in the buffer, fail if it is empty
  """
  @spec read(buffer :: pid) :: {:ok, any} | {:error, atom}
  def read(buffer) do
    Agent.get_and_update(buffer, fn
      %{elements: []} = state ->
        {{:error, :empty}, state}

      %{elements: [h | t], capacity: capacity} ->
        {{:ok, h}, %__MODULE__{elements: t, capacity: capacity}}
    end)
  end

  @doc """
  Write a new item in the buffer, fail if is full
  """
  @spec write(buffer :: pid, item :: any) :: :ok | {:error, atom}
  def write(buffer, item) do
    Agent.get_and_update(buffer, fn
      %{elements: elements, capacity: capacity} = state when length(elements) == capacity ->
        {{:error, :full}, state}

      state ->
        {:ok, Map.update!(state, :elements, fn elements -> elements ++ [item] end)}
    end)
  end

  @doc """
  Write an item in the buffer, overwrite the oldest entry if it is full
  """
  @spec overwrite(buffer :: pid, item :: any) :: :ok
  def overwrite(buffer, item) do
    Agent.get_and_update(buffer, fn
      %{elements: elements, capacity: capacity} = state when length(elements) == capacity ->
        {:ok, Map.update!(state, :elements, fn [_h | t] -> t ++ [item] end)}

      state ->
        {:ok, Map.update!(state, :elements, fn elements -> elements ++ [item] end)}
    end)
  end

  @doc """
  Clear the buffer
  """
  @spec clear(buffer :: pid) :: :ok
  def clear(buffer) do
    Agent.update(buffer, fn state -> Map.put(state, :elements, []) end)
  end
end
