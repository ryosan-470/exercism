defmodule RobotSimulator do
  @doc """
  Create a Robot Simulator given an initial direction and position.

  Valid directions are: `:north`, `:east`, `:south`, `:west`
  """
  defmodule Robot do
    defstruct [:position, :direction, :errors]
  end

  @spec create(direction :: atom, position :: {integer, integer}) :: any
  def create(direction \\ :north, position \\ {0, 0})

  def create(direction, _) when direction not in ~w(north east south west)a,
    do: {:error, "invalid direction"}

  def create(direction, {x, y} = position) when is_integer(x) and is_integer(y) do
    %Robot{direction: direction, position: position}
  end

  def create(_, _), do: {:error, "invalid position"}

  @doc """
  Simulate the robot's movement given a string of instructions.

  Valid instructions are: "R" (turn right), "L", (turn left), and "A" (advance)
  """
  @spec simulate(robot :: any, instructions :: String.t()) :: any
  def simulate(robot, instructions) do
    with %Robot{errors: nil} = robot <-
           instructions
           |> String.codepoints()
           |> Enum.reduce(robot, fn x, r ->
             r |> do_simulate(x)
           end) do
      robot
    else
      %Robot{errors: errors} -> {:error, errors}
    end
  end

  defp do_simulate(%Robot{direction: :north} = robot, "R"), do: %{robot | direction: :east}
  defp do_simulate(%Robot{direction: :east} = robot, "R"), do: %{robot | direction: :south}
  defp do_simulate(%Robot{direction: :south} = robot, "R"), do: %{robot | direction: :west}
  defp do_simulate(%Robot{direction: :west} = robot, "R"), do: %{robot | direction: :north}

  defp do_simulate(%Robot{direction: :north} = robot, "L"), do: %{robot | direction: :west}
  defp do_simulate(%Robot{direction: :west} = robot, "L"), do: %{robot | direction: :south}
  defp do_simulate(%Robot{direction: :south} = robot, "L"), do: %{robot | direction: :east}
  defp do_simulate(%Robot{direction: :east} = robot, "L"), do: %{robot | direction: :north}

  defp do_simulate(%Robot{direction: :east, position: {x, y}} = robot, "A") do
    %{robot | position: {x + 1, y}}
  end

  defp do_simulate(%Robot{direction: :west, position: {x, y}} = robot, "A") do
    %{robot | position: {x - 1, y}}
  end

  defp do_simulate(%Robot{direction: :north, position: {x, y}} = robot, "A") do
    %{robot | position: {x, y + 1}}
  end

  defp do_simulate(%Robot{direction: :south, position: {x, y}} = robot, "A") do
    %{robot | position: {x, y - 1}}
  end

  defp do_simulate(robot, _), do: %{robot | errors: "invalid instruction"}

  @doc """
  Return the robot's direction.

  Valid directions are: `:north`, `:east`, `:south`, `:west`
  """
  @spec direction(robot :: any) :: atom
  def direction(%Robot{direction: direction}), do: direction

  @doc """
  Return the robot's position.
  """
  @spec position(robot :: any) :: {integer, integer}
  def position(%Robot{position: position}), do: position
end
