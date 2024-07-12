defmodule Input do
  def read(day) do
    day
    |> stringified_day()
    |> then(fn day ->
      File.read!("lib/#{day}/input")
    end)
  end

  def lines(day) do
    read(day)
    |> String.split("\n")
  end

  def stringified_day(day) do
    day
    |> to_string()
    |> String.pad_leading(2, "0")
    |> then(fn d -> "day_#{d}" end)
  end
end
