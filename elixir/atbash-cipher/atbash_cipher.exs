defmodule Atbash do
  @doc """
  Encode a given plaintext to the corresponding ciphertext

  ## Examples

  iex> Atbash.encode("completely insecure")
  "xlnko vgvob rmhvx fiv"
  """
  @alphabet ?a..?z |> Enum.to_list() |> to_string |> String.codepoints()
  @reversed ?z..?a |> Enum.to_list() |> to_string |> String.codepoints()

  @spec encode(String.t()) :: String.t()
  def encode(plaintext) do
    plaintext
    |> String.downcase()
    |> String.replace(" ", "")
    |> String.codepoints()
    |> Enum.map(fn x ->
      idx = @alphabet |> Enum.find_index(&(&1 == x))

      cond do
        !is_nil(idx) ->
          @reversed |> Enum.at(idx)

        x in ~w(1 2 3 4 5 6 7 8 9 0) ->
          x

        true ->
          nil
      end
    end)
    |> Enum.reject(&is_nil/1)
    |> Enum.chunk_every(5)
    |> Enum.map(&(&1 |> Enum.join()))
    |> Enum.join(" ")
  end

  @spec decode(String.t()) :: String.t()
  def decode(cipher) do
    cipher
    |> String.replace(" ", "")
    |> String.codepoints()
    |> Enum.map(fn x ->
      idx = @reversed |> Enum.find_index(&(&1 == x))

      cond do
        !is_nil(idx) ->
          @alphabet |> Enum.at(idx)

        x in ~w(1 2 3 4 5 6 7 8 9 0) ->
          x

        true ->
          nil
      end
    end)
    |> Enum.reject(&is_nil/1)
    |> Enum.join()
  end
end
