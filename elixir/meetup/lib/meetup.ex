defmodule Meetup do
  @moduledoc """
  Calculate meetup dates.
  """

  @type weekday ::
          :monday
          | :tuesday
          | :wednesday
          | :thursday
          | :friday
          | :saturday
          | :sunday

  @type schedule :: :first | :second | :third | :fourth | :last | :teenth

  @doc """
  Calculate a meetup date.

  The schedule is in which week (1..4, last or "teenth") the meetup date should
  fall.
  """
  @spec meetup(pos_integer, pos_integer, weekday, schedule) :: :calendar.date()
  def meetup(year, month, weekday, schedule) do
    {:ok, first} = Date.new(year, month, 1)
    {:ok, last} = Date.new(year, month, Date.days_in_month(first))

    candidates =
      Date.range(first, last)
      |> Enum.filter(&(&1 |> Date.day_of_week() == weekday_to_integer(weekday)))

    case schedule do
      :first -> candidates |> List.first()
      :second -> candidates |> Enum.at(1)
      :third -> candidates |> Enum.at(2)
      :fourth -> candidates |> Enum.at(3)
      :last -> candidates |> List.last()
      :teenth -> candidates |> Enum.filter(&(&1.day in 10..19)) |> List.last()
    end
  end

  defp weekday_to_integer(:monday), do: 1
  defp weekday_to_integer(:tuesday), do: 2
  defp weekday_to_integer(:wednesday), do: 3
  defp weekday_to_integer(:thursday), do: 4
  defp weekday_to_integer(:friday), do: 5
  defp weekday_to_integer(:saturday), do: 6
  defp weekday_to_integer(:sunday), do: 7
end
