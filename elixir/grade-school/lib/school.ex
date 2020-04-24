defmodule School do
  @moduledoc """
  Simulate students in a school.

  Each student is in a grade.
  """

  @doc """
  Add a student to a particular grade in school.
  """
  @spec add(map, String.t(), integer) :: map
  def add(db, name, grade) do
    db
    |> Map.fetch(grade)
    |> case do
      {:ok, list} -> %{db | grade => [name | list]}
      :error -> %{grade => [name]} |> Map.merge(db)
    end
  end

  @doc """
  Return the names of the students in a particular grade.
  """
  @spec grade(map, integer) :: [String.t()]
  def grade(db, grade) do
    Map.get(db, grade, [])
  end

  @doc """
  Sorts the school by grade and name.
  """
  @spec sort(map) :: [{integer, [String.t()]}]
  def sort(db) do
    db |> Map.keys() |> Enum.sort(&(&1 <= &2)) |> Enum.map(fn k -> {k, db[k] |> Enum.sort()} end)
  end
end
