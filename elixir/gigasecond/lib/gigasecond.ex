defmodule Gigasecond do
  @doc """
  Calculate a date one billion seconds after an input date.
  """
  @spec from({{pos_integer, pos_integer, pos_integer}, {pos_integer, pos_integer, pos_integer}}) ::
          :calendar.datetime()

  def from({{year, month, day}, {hours, minutes, seconds}}) do
    c =
      NaiveDateTime.new(year, month, day, hours, minutes, seconds)
      |> elem(1)
      |> NaiveDateTime.add(1_000_000_000)

    {{c.year, c.month, c.day}, {c.hour, c.minute, c.second}}
  end
end
