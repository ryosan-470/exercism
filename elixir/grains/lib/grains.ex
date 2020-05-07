defmodule Grains do
  @doc """
  Calculate two to the power of the input minus one.
  """
  @spec square(pos_integer) :: {:ok, pos_integer} | {:error, String.t()}
  def square(number) when 1 <= number and number <= 64, do: {:ok, pow(2, number - 1)}
  def square(_), do: {:error, "The requested square must be between 1 and 64 (inclusive)"}

  # O(log(n))
  defp pow(_x, 0), do: 1
  defp pow(x, n) when rem(n, 2) == 0, do: pow(x * x, div(n, 2))
  defp pow(x, n), do: x * pow(x, n - 1)

  @doc """
  Adds square of each number from 1 to 64.
  """
  @spec total :: {:ok, pos_integer}
  def total do
    total = 1..64 |> Enum.map(&(square(&1) |> elem(1))) |> Enum.sum()
    {:ok, total}
  end
end
