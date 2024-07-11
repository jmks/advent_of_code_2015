defmodule Day02.NoMath do
  def wrapping_area(dimensions) do
    [l, w, h] = parse(dimensions)

    sides = [
      l * w,
      w * h,
      h * l,
    ]

    slack = Enum.min(sides)

    2 * Enum.sum(sides) + slack
  end

  def ribbon_length(dimensions) do
    [l, w, h] = parse(dimensions)

    perimeters = [
      2 * (l + w),
      2 * (w + h),
      2 * (h + l),
    ]
    around = Enum.min(perimeters)

    volume = l * w * h

    around + volume
  end

  defp parse(dimensions) do
    dimensions
    |> String.split("x")
    |> Enum.map(&String.to_integer/1)
  end
end
