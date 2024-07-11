defmodule Day01.NotQuiteLisp do
  def follow(path) do
    path
    |> String.codepoints()
    |> Enum.reduce(0, fn
      "(", floor -> floor + 1
      ")", floor -> floor - 1
    end)
  end
end
