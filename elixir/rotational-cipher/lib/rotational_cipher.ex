defmodule RotationalCipher do
  @doc """
  Given a plaintext and amount to shift by, return a rotated string.

  Example:
  iex> RotationalCipher.rotate("Attack at dawn", 13)
  "Nggnpx ng qnja"
  """
  @spec rotate(text :: String.t(), shift :: integer) :: String.t()
  def rotate(text, shift) do
    text
    |> String.codepoints()
    |> do_rotate(shift, "")
  end

  defp do_rotate([head | tail], shift, acc) do
    <<c>> = head
    acc = acc <> List.to_string([do_rotate(c, shift)])
    do_rotate(tail, shift, acc)
  end

  defp do_rotate([], _shift, acc), do: acc

  defp do_rotate(c, shift) when c in ?a..?z do
    rem(c - ?a + shift, 26) + ?a
  end

  defp do_rotate(c, shift) when c in ?A..?Z do
    rem(c - ?A + shift, 26) + ?A
  end

  defp do_rotate(c, _shift), do: c
end
