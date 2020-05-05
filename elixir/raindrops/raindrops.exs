defmodule Raindrops do
  @doc """
  Returns a string based on raindrop factors.

  - If the number contains 3 as a prime factor, output 'Pling'.
  - If the number contains 5 as a prime factor, output 'Plang'.
  - If the number contains 7 as a prime factor, output 'Plong'.
  - If the number does not contain 3, 5, or 7 as a prime factor,
    just pass the number's digits straight through.
  """
  @spec convert(pos_integer) :: String.t()
  def convert(number) do
    result =
      [do_convert_by_three(number), do_convert_by_five(number), do_convert_by_seven(number)]
      |> Enum.join()

    if String.length(result) == 0 do
      "#{number}"
    else
      result
    end
  end

  def do_convert_by_three(n) when rem(n, 3) == 0, do: "Pling"
  def do_convert_by_three(_), do: nil
  def do_convert_by_five(n) when rem(n, 5) == 0, do: "Plang"
  def do_convert_by_five(_), do: nil
  def do_convert_by_seven(n) when rem(n, 7) == 0, do: "Plong"
  def do_convert_by_seven(_), do: nil
end
