defmodule Bowling do
  @end_game nil

  @doc """
    Creates a new game of bowling that can be used to store the results of
    the game
  """
  @spec start() :: any
  def start do
    %{frames: [], current_frame: {:open, 1, rolls: []}}
  end

  @doc """
    Records the number of pins knocked down on a single roll. Returns `any`
    unless there is something wrong with the given number of pins, in which
    case it returns a helpful message.
  """
  @spec roll(any, integer) :: any | String.t()
  def roll(_game, roll) when roll < 0, do: {:error, "Negative roll is invalid"}
  def roll(_game, roll) when roll > 10, do: {:error, "Pin count exceeds pins on the lane"}

  def roll(%{current_frame: nil}, _), do: {:error, "Cannot roll after game is over"}

  def roll(game, roll) do
    roll
    |> add_to_frame(game.current_frame)
    |> add_to_game(game)
  end

  def score(%{current_frame: current_frame}) when current_frame != @end_game do
    {:error, "Score cannot be taken until the end of the game"}
  end

  def score(game) do
    score(0, game.frames, [0, 0])
  end

  defp add_to_frame(roll, {type, _, rolls: [previous_roll]})
       when type in [:strike_bonus_2, :half] and roll + previous_roll > 10 do
    {:error, "Pin count exceeds pins on the lane"}
  end

  defp add_to_frame(10, {:open, n, _}) do
    {:strike, n, rolls: [10]}
  end

  defp add_to_frame(roll, {:half, n, rolls: [previous_roll]}) when roll + previous_roll == 10 do
    {:spare, n, rolls: [previous_roll, roll]}
  end

  defp add_to_frame(roll, {:open, n, _}) do
    {:half, n, rolls: [roll]}
  end

  defp add_to_frame(roll, {:half, n, rolls: [previous_roll]}) do
    {:closed, n, rolls: [previous_roll, roll]}
  end

  defp add_to_frame(roll, {type, n, rolls: previous_roll}) do
    {type, n, rolls: previous_roll ++ [roll]}
  end

  defp add_to_game(error = {:error, _}, _) do
    error
  end

  defp add_to_game(frame = {type, _, _}, game)
       when type in [:closed, :spare, :strike, :spare_bonus, :strike_bonus_2] do
    %{game | frames: [frame | game.frames], current_frame: next_frame(frame)}
  end

  defp add_to_game(frame = {:strike_bonus_1, _, rolls: [10]}, game) do
    %{game | frames: [frame | game.frames], current_frame: next_frame(frame)}
  end

  defp add_to_game(frame, game) do
    %{game | current_frame: next_frame(frame)}
  end

  defp next_frame({:closed, 10, _}), do: @end_game
  defp next_frame({:spare_bonus, _, _}), do: @end_game
  defp next_frame({:strike_bonus_2, _, _}), do: @end_game
  defp next_frame({:strike, 10, _}), do: {:strike_bonus_1, 11, rolls: []}
  defp next_frame({:strike_bonus_1, _, rolls: [10]}), do: {:strike_bonus_2, 12, rolls: []}
  defp next_frame({:strike_bonus_1, _, rolls: rolls}), do: {:strike_bonus_2, 11, rolls: rolls}
  defp next_frame({:spare, 10, _}), do: {:spare_bonus, 11, rolls: []}
  defp next_frame(current_frame = {:half, _, _}), do: current_frame
  defp next_frame({_, n, _}), do: {:open, n + 1, rolls: []}

  defp score(score, [], _), do: score

  defp score(score, [{_, n, rolls: rolls} | t], previous) when n > 10 do
    score(score, t, Enum.take(rolls ++ previous, 2))
  end

  defp score(score, [{:strike, _, rolls: rolls} | t], previous = [bonus1, bonus2]) do
    score = score + Enum.sum(rolls) + bonus1 + bonus2
    score(score, t, Enum.take(rolls ++ previous, 2))
  end

  defp score(score, [{:spare, _, rolls: rolls} | t], previous = [bonus1, _]) do
    score = score + Enum.sum(rolls) + bonus1
    score(score, t, Enum.take(rolls ++ previous, 2))
  end

  defp score(score, [{_, _, rolls: rolls} | t], _) do
    score = score + Enum.sum(rolls)
    score(score, t, rolls)
  end
end
