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

  @week %{monday: 1, tuesday: 2, wednesday: 3, thursday: 4, friday: 5, saturday: 6, sunday: 7}

  @doc """
  Calculate a meetup date.

  The schedule is in which week (1..4, last or "teenth") the meetup date should
  fall.
  """
  @spec meetup(pos_integer, pos_integer, weekday, schedule) :: :calendar.date()
  def meetup(year, month, weekday, schedule) do
    day = first_day_of_the_month(year, month, weekday)
    {year, month, day |> per_schedule(schedule, year, month)}
  end

  defp per_schedule(first, :first, _, _), do: first
  defp per_schedule(first, :second, _, _), do: first + 7
  defp per_schedule(first, :third, _, _), do: first + 14
  defp per_schedule(first, :fourth, _, _), do: first + 21
  defp per_schedule(first, :teenth, _, _), do: rem((first - 13 + 28), 7) + 13
  defp per_schedule(first, :last, year, month) do
    {:ok, first_day_of_the_month} = Date.new(year, month, 1)
    days_in_month = Date.days_in_month(first_day_of_the_month)
    x = days_in_month - 6
    rem(first - x + 28, 7) + x
  end

  defp first_day_of_the_month(year, month, weekday) do
    {:ok, first_day_of_the_month} = Date.new(year, month, 1)
    day_of_first_day_of_the_month = Date.day_of_week(first_day_of_the_month)

    weekday_int = @week[weekday]

    rem((weekday_int - day_of_first_day_of_the_month + 7), 7) + 1
  end
end
