defmodule SecretHandshake do
  @doc """
  Determine the actions of a secret handshake based on the binary
  representation of the given `code`.

  If the following bits are set, include the corresponding action in your list
  of commands, in order from lowest to highest.

  1 = wink
  10 = double blink
  100 = close your eyes
  1000 = jump

  10000 = Reverse the order of the operations in the secret handshake
  """
  use Bitwise

  @spec commands(code :: integer) :: list(String.t())
  def commands(code) do
    []
    |> commands(code &&& 0b00001)
    |> commands(code &&& 0b00010)
    |> commands(code &&& 0b00100)
    |> commands(code &&& 0b01000)
    |> commands(code &&& 0b10000)
    |> Enum.reverse()
  end

  def commands(list, 0b00001), do: ["wink" | list]
  def commands(list, 0b00010), do: ["double blink" | list]
  def commands(list, 0b00100), do: ["close your eyes" | list]
  def commands(list, 0b01000), do: ["jump" | list]
  def commands(list, 0b10000), do: Enum.reverse(list)
  def commands(list, _), do: list
end
