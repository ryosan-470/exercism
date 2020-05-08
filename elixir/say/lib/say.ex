defmodule Say do
  @doc """
  Translate a positive integer into English.
  """
  @min 0
  @max 999_999_999_999

  @base %{
    0 => "zero",
    1 => "one",
    2 => "two",
    3 => "three",
    4 => "four",
    5 => "five",
    6 => "six",
    7 => "seven",
    8 => "eight",
    9 => "nine",
    10 => "ten",
    11 => "eleven",
    12 => "twelve",
    13 => "thirteen",
    14 => "fourteen",
    15 => "fifteen",
    16 => "sixteen",
    17 => "seventeen",
    18 => "eighteen",
    19 => "nineteen",
    20 => "twenty",
    30 => "thirty",
    40 => "forty",
    50 => "fifty",
    60 => "sixty",
    70 => "seventy",
    80 => "eighty",
    90 => "ninety"
  }

  @spec in_english(integer) :: {atom, String.t()}
  def in_english(number) when @min <= number and number <= @max do
    {:ok, english(number)}
  end

  def in_english(_number), do: {:error, "number is out of range"}

  defp english(number) when number <= 20, do: @base[number]

  defp english(number) when number < 100 do
    case rem(number, 10) do
      0 -> @base[number]
      k -> "#{@base[number - k]}-#{@base[k]}"
    end
  end

  defp english(number) when number < 1_000 do
    calc(number, 100, "hundred")
  end

  defp english(number) when number < 1_000_000 do
    calc(number, 1000, "thousand")
  end

  defp english(number) when number < 1_000_000_000 do
    calc(number, 1_000_000, "million")
  end

  defp english(number) when number < 1_000_000_000_000 do
    calc(number, 1_000_000_000, "billion")
  end

  defp calc(number, base, suffix) do
    units = div(number, base)
    prefix = "#{english(units)} #{suffix}"

    case rem(number, base) do
      0 -> prefix
      k -> "#{prefix} #{english(k)}"
    end
  end
end
