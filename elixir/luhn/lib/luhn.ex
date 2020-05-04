defmodule Luhn do
  @doc """
  Checks if the given number is valid via the luhn formula
  """
  @spec valid?(String.t()) :: boolean
  def valid?(number) do
    with trimmed <-
           number |> String.trim() |> String.trim_leading("0") |> String.split() |> Enum.join(),
         true <- String.length(trimmed) >= 1 do
      if trimmed |> String.length() |> Kernel.rem(2) != 0 do
        "#{trimmed}0"
      else
        trimmed
      end
      |> String.codepoints()
      |> Enum.map(&String.to_integer/1)
      |> Enum.chunk_every(2)
      |> Enum.reduce(0, fn [x, y], acc ->
        doubled = x * 2

        if doubled > 9 do
          doubled - 9 + y
        else
          doubled + y
        end + acc
      end)
      |> Kernel.rem(10) == 0
    else
      false -> false
    end
  rescue
    _ ->
      false
  end
end
