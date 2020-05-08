defmodule Triangle do
  @type kind :: :equilateral | :isosceles | :scalene

  @doc """
  Return the kind of triangle of a triangle with 'a', 'b' and 'c' as lengths.
  """
  @spec kind(number, number, number) :: {:ok, kind} | {:error, String.t()}
  def kind(a, b, c) do
    with sides <- [a, b, c],
         true <- sides |> Enum.all?(&(&1 > 0)) || {:error, "all side lengths must be positive"},
         # detect `z`
         z <- sides |> Enum.max(),
         idx <- sides |> Enum.find_index(&(&1 == z)),
         # validate: `z < x + y`
         true <-
           sides |> List.delete_at(idx) |> Enum.sum() |> Kernel.>(z) ||
             {:error, "side lengths violate triangle inequality"} do
      sides
      |> Enum.filter(&(&1 == z))
      |> Enum.count()
      |> case do
        1 -> {:ok, :scalene}
        2 -> {:ok, :isosceles}
        3 -> {:ok, :equilateral}
      end
    else
      e -> e
    end
  end
end
