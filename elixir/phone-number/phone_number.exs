defmodule Phone do
  @doc """
  Remove formatting from a phone number.

  Returns "0000000000" if phone number is not valid
  (10 digits or "1" followed by 10 digits)

  ## Examples

  iex> Phone.number("212-555-0100")
  "2125550100"

  iex> Phone.number("+1 (212) 555-0100")
  "2125550100"

  iex> Phone.number("+1 (212) 055-0100")
  "0000000000"

  iex> Phone.number("(212) 555-0100")
  "2125550100"

  iex> Phone.number("867.5309")
  "0000000000"
  """
  @spec number(String.t()) :: String.t()
  def number(raw) do
    with {:ok, numbered} <- raw |> to_numbered(),
         :ok <- numbered |> valid_area_code(),
         :ok <- numbered |> valid_exchange_code() do
      numbered
    else
      _ -> String.duplicate("0", 10)
    end
  end

  @doc """
  Extract the area code from a phone number

  Returns the first three digits from a phone number,
  ignoring long distance indicator

  ## Examples

  iex> Phone.area_code("212-555-0100")
  "212"

  iex> Phone.area_code("+1 (212) 555-0100")
  "212"

  iex> Phone.area_code("+1 (012) 555-0100")
  "000"

  iex> Phone.area_code("867.5309")
  "000"
  """
  @spec area_code(String.t()) :: String.t()
  def area_code(raw) do
    with {:ok, numbered} <- raw |> to_numbered(),
         {:ok, numbered} <- numbered |> valid_country_code(),
         :ok <- numbered |> valid_area_code() do
      numbered |> String.slice(0, 3)
    else
      _ -> "000"
    end
  end

  @doc """
  Pretty print a phone number

  Wraps the area code in parentheses and separates
  exchange and subscriber number with a dash.

  ## Examples

  iex> Phone.pretty("212-555-0100")
  "(212) 555-0100"

  iex> Phone.pretty("212-155-0100")
  "(000) 000-0000"

  iex> Phone.pretty("+1 (303) 555-1212")
  "(303) 555-1212"

  iex> Phone.pretty("867.5309")
  "(000) 000-0000"
  """
  @spec pretty(String.t()) :: String.t()
  def pretty(raw) do
    number = raw |> number()

    "(#{area_code(number)}) #{String.slice(number, 3, 3)}-#{String.slice(number, 6, 4)}"
  end

  defp to_numbered(raw) do
    with false <- Regex.match?(~r/[a-zA-Z]/, raw),
         numbered <- Regex.scan(~r/[0-9]+/, raw) |> Enum.join(),
         {:ok, numbered} <- numbered |> valid_country_code() do
      {:ok, numbered}
    else
      _ -> :error
    end
  end

  # 長さ10の文字列を返す
  defp valid_country_code(number) do
    number
    |> String.length()
    |> case do
      10 ->
        {:ok, number}

      11 ->
        if number |> String.first() == "1" do
          {:ok, number |> String.slice(1, 10)}
        end

      _ ->
        {:error, :invalid_country_code}
    end
  end

  defp valid_area_code(number) do
    number
    |> String.first()
    |> case do
      "0" -> {:error, :invalid_area_code}
      "1" -> {:error, :invalid_area_code}
      _ -> :ok
    end
  end

  defp valid_exchange_code(number) do
    number
    |> String.slice(3, 3)
    |> String.first()
    |> case do
      "0" -> {:error, :invalid_exchange_code}
      "1" -> {:error, :invalid_exchange_code}
      _ -> :ok
    end
  end
end
