# Use the Plot struct as it is provided
defmodule Plot do
  @enforce_keys [:plot_id, :registered_to]
  defstruct [:plot_id, :registered_to]
end

defmodule CommunityGarden do
  def start(_opts \\ []) do
    Agent.start(fn -> %{current_id: 0, plots: %{}} end)
  end

  def list_registrations(pid) do
    Agent.get(pid, fn state -> Map.values(state.plots) end)
  end

  def register(pid, register_to) do
    Agent.get_and_update(pid, fn %{current_id: current_id, plots: plots} ->
      next_id = current_id + 1
      plot = %Plot{plot_id: next_id, registered_to: register_to}
      {plot, %{current_id: next_id, plots: Map.put(plots, next_id, plot)}}
    end)
  end

  def release(pid, plot_id) do
    Agent.update(pid, fn state -> %{state | plots: Map.delete(state.plots, plot_id)} end)
  end

  def get_registration(pid, plot_id) do
    Agent.get(pid, fn %{plots: plots} ->
      Map.get(plots, plot_id, {:not_found, "plot is unregistered"})
    end)
  end
end
