defmodule TakeANumber do
  def start() do
    spawn(fn -> loop(0) end)
  end

  defp loop(state) do
    state =
      receive do
        :stop -> exit(:stop)
        {:report_state, sender} -> send(sender, state)
        {:take_a_number, sender} -> send(sender, state + 1)
        _ -> state
      end

    loop(state)
  end
end
