defmodule Input do
  def read(day) do
    day
    |> to_string()
    |> String.pad_leading(2, "0")
    |> then(fn day ->
      File.read!("lib/day_#{day}/input")
    end)
  end
end
