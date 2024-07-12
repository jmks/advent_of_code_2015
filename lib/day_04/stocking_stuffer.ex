defmodule Day04.StockingStuffer do
  def decimal(secret_key) do
    do_decimal(secret_key, 1)
  end

  defp do_decimal(secret, number) do
    hash =
      :crypto.hash(:md5 , secret <> to_string(number))
      |> Base.encode16()

    if String.starts_with?(hash, "00000") do
      number
    else
      do_decimal(secret, number + 1)
    end
  end
end
