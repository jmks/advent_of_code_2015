defmodule Day02.NoMath do
  def wrapping_area(dimensions) do
    [l, w, h] = parse(dimensions)

    sides = [
      l * w,
      w * h,
      h * l
    ]

    slack = Enum.min(sides)

    2 * Enum.sum(sides) + slack
  end

  defp parse(dimensions) do
    dimensions
    |> String.split("x")
    |> Enum.map(&String.to_integer/1)
  end
end
