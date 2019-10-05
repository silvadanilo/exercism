defmodule RobotSimulator do
  defstruct position: {0, 0}, direction: :north

  @doc """
  Create a Robot Simulator given an initial direction and position.

  Valid directions are: `:north`, `:east`, `:south`, `:west`
  """
  @directions [:north, :east, :south, :west]

  @spec create(direction :: atom, position :: {integer, integer}) :: any
  def create(direction \\ :north, position \\ {0, 0})

  def create(direction, _) when direction not in @directions do
    {:error, "invalid direction"}
  end

  def create(_direction, position) when not (is_tuple(position) and tuple_size(position) == 2) do
    {:error, "invalid position"}
  end

  def create(_direction, _position = {x, y}) when not (is_integer(x) and is_integer(y)) do
    {:error, "invalid position"}
  end

  def create(direction, position) do
    %RobotSimulator{direction: direction_index(direction), position: position}
  end

  @doc """
  Return the robot's direction.

  Valid directions are: `:north`, `:east`, `:south`, `:west`
  """
  @spec direction(robot :: any) :: atom
  def direction(robot) do
    Enum.at(@directions, robot.direction)
  end

  @doc """
  Return the robot's position.
  """
  @spec position(robot :: any) :: {integer, integer}
  def position(robot) do
    robot.position
  end

  @doc """
  Simulate the robot's movement given a string of instructions.

  Valid instructions are: "R" (turn right), "L", (turn left), and "A" (advance)
  """
  @spec simulate(robot :: any, instructions :: String.t()) :: any
  def simulate(robot, instructions) do
    do_simulate(robot, String.codepoints(instructions))
  end

  defp do_simulate(robot, []), do: robot

  defp do_simulate(robot, ["L" | tail]) do
    %{robot | direction: turn(robot.direction, -1)}
    |> do_simulate(tail)
  end

  defp do_simulate(robot, ["R" | tail]) do
    %{robot | direction: turn(robot.direction, +1)}
    |> do_simulate(tail)
  end

  defp do_simulate(robot, ["A" | tail]) do
    %{robot | position: advance(direction(robot), robot.position)}
    |> do_simulate(tail)
  end

  defp do_simulate(_, [_invalid_instruction | _]) do
    {:error, "invalid instruction"}
  end

  defp advance(direction, {x, y}) do
    case direction do
      :north -> {x, y + 1}
      :west -> {x - 1, y}
      :south -> {x, y - 1}
      :east -> {x + 1, y}
    end
  end

  defp turn(current_direction, turn_on) do
    rem(current_direction + turn_on, 4)
  end

  defp direction_index(direction) do
    Enum.find_index(@directions, &(&1 === direction))
  end
end
