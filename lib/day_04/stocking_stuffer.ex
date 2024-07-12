defmodule Day04.StockingStuffer do
  def decimal(secret_key, leading_zeros \\ 5) do
    do_decimal(secret_key, leading_zeros, 1)
  end

  defp do_decimal(secret, zeros, number) do
    hash =
      :crypto.hash(:md5 , secret <> to_string(number))
      |> Base.encode16()

    if String.starts_with?(hash, String.duplicate("0", zeros)) do
      number
    else
      do_decimal(secret, zeros, number + 1)
    end
  end
end
