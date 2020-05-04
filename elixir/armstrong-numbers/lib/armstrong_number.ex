defmodule ArmstrongNumber do
  @moduledoc """
  Provides a way to validate whether or not a number is an Armstrong number
  """

  @spec valid?(integer) :: boolean
  def valid?(number) do
    digits = number |> Integer.to_string() |> String.length()

    number
    |> Integer.to_string()
    |> String.codepoints()
    |> Enum.reduce(0, fn x, acc ->
      (x |> String.to_integer() |> :math.pow(digits) |> round()) + acc
    end)
    |> Kernel.==(number)
  end
end
