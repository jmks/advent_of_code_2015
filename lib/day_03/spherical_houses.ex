defmodule Day03.SphericalHouses do
  def unique_houses(moves) do
    moves
    |> String.codepoints()
    |> do_moves({0, 0}, MapSet.new())
    |> MapSet.size()
  end

  def robo_houses(moves) do
    [santa, robot] =
      moves
      |> String.codepoints()
      |> Enum.with_index()
      |> Enum.group_by(
        fn {_v, i} -> rem(i, 2) end,
        fn {v, _i} -> v end
      )
      |> Map.values()
      |> Enum.map(&do_moves(&1, {0, 0}, MapSet.new()))

      santa
      |> MapSet.union(robot)
      |> MapSet.size()
  end

  defp do_moves(moves, position, visited)

  defp do_moves([], position, visited) do
    MapSet.put(visited, position)
  end

  defp do_moves([move | moves], position, visited) do
    new_position = follow(move, position)
    new_visited = MapSet.put(visited, position)

    do_moves(moves, new_position, new_visited)
  end

  defp follow("<", {x, y}), do: {x - 1, y}
  defp follow(">", {x, y}), do: {x + 1, y}
  defp follow("^", {x, y}), do: {x, y + 1}
  defp follow("v", {x, y}), do: {x, y - 1}
end
