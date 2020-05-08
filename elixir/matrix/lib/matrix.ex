defmodule Matrix do
  defstruct matrix: nil

  @doc """
  Convert an `input` string, with rows separated by newlines and values
  separated by single spaces, into a `Matrix` struct.
  """
  @spec from_string(input :: String.t()) :: %Matrix{}
  def from_string(input) do
    %Matrix{
      matrix:
        input
        |> String.split("\n")
        |> Enum.map(&(&1 |> String.split() |> Enum.map(fn x -> x |> String.to_integer() end)))
    }
  end

  @doc """
  Write the `matrix` out as a string, with rows separated by newlines and
  values separated by single spaces.
  """
  @spec to_string(matrix :: %Matrix{}) :: String.t()
  def to_string(%{matrix: matrix}) do
    matrix |> Enum.map_join("\n", &(&1 |> Enum.join(" ")))
  end

  @doc """
  Given a `matrix`, return its rows as a list of lists of integers.
  """
  @spec rows(matrix :: %Matrix{}) :: list(list(integer))
  def rows(%{matrix: matrix}), do: matrix

  @doc """
  Given a `matrix` and `index`, return the row at `index`.
  """
  @spec row(matrix :: %Matrix{}, index :: integer) :: list(integer)
  def row(%{matrix: matrix}, index), do: matrix |> Enum.at(index)

  @doc """
  Given a `matrix`, return its columns as a list of lists of integers.
  """
  @spec columns(matrix :: %Matrix{}) :: list(list(integer))
  def columns(%{matrix: m} = matrix) do
    0..(length(m) - 1) |> Enum.map(&column(matrix, &1))
  end

  @doc """
  Given a `matrix` and `index`, return the column at `index`.
  """
  @spec column(matrix :: %Matrix{}, index :: integer) :: list(integer)
  def column(%{matrix: matrix}, index) do
    matrix |> Enum.map(&(&1 |> Enum.at(index)))
  end
end
