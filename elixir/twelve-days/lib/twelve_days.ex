defmodule TwelveDays do
  @doc """
  Given a `number`, return the song's verse for that specific day, including
  all gifts for previous days in the same line.
  """
  @spec verse(number :: integer) :: String.t()
  def verse(number) do
    "#{first_sentence(number)} #{
      1..number
      |> Enum.reduce([], fn x, acc -> [TwelveDays.second_sentence(x) | acc] end)
      |> Enum.join(" ")
    }"
  end

  @doc """
  Given a `starting_verse` and an `ending_verse`, return the verses for each
  included day, one per line.
  """
  @spec verses(starting_verse :: integer, ending_verse :: integer) :: String.t()
  def verses(starting_verse, ending_verse) do
    starting_verse..ending_verse |> Enum.map_join("\n", &verse/1)
  end

  @doc """
  Sing all 12 verses, in order, one verse per line.
  """
  @spec sing() :: String.t()
  def sing, do: verses(1, 12) |> String.trim()

  defp ordinal(number) do
    case number do
      1 -> "first"
      2 -> "second"
      3 -> "third"
      4 -> "fourth"
      5 -> "fifth"
      6 -> "sixth"
      7 -> "seventh"
      8 -> "eighth"
      9 -> "ninth"
      10 -> "tenth"
      11 -> "eleventh"
      12 -> "twelfth"
    end
  end

  def first_sentence(number) do
    "On the #{ordinal(number)} day of Christmas my true love gave to me:"
  end

  def second_sentence(number) do
    case number do
      1 -> "a Partridge in a Pear Tree."
      2 -> "two Turtle Doves, and"
      3 -> "three French Hens,"
      4 -> "four Calling Birds,"
      5 -> "five Gold Rings,"
      6 -> "six Geese-a-Laying,"
      7 -> "seven Swans-a-Swimming,"
      8 -> "eight Maids-a-Milking,"
      9 -> "nine Ladies Dancing,"
      10 -> "ten Lords-a-Leaping,"
      11 -> "eleven Pipers Piping,"
      12 -> "twelve Drummers Drumming,"
    end
  end
end
