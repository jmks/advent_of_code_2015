defmodule Day01.NotQuiteLisp do
  def follow(path) do
    path
    |> String.codepoints()
    |> Enum.map(&move/1)
    |> Enum.sum()
  end

  def enter_basement(path) do
    path
    |> String.codepoints()
    |> do_enter_basement(0, 0)
  end

  defp do_enter_basement(chars, floor, count)

  defp do_enter_basement(_, -1, count), do: count
  defp do_enter_basement([char | chars], floor, count) do
    do_enter_basement(chars, move(char) + floor, count + 1)
  end

  defp move("("), do: 1
  defp move(")"), do: -1
end
