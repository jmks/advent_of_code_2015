defmodule Day06.FireHazard do
  def parse_instructions(instructions) do
    instructions
    |> String.split("\n", trim: true)
    |> Enum.map(&parse_instruction/1)
  end

  def new(size \\ 1_000) do
    for x <- 0..size, y <- 0..size, into: %{} do
      {{x, y}, false}
    end
  end

  def apply_instruction(grid, instructions) when is_list(instructions) do
    Enum.reduce(instructions, grid, &apply_to_grid/2)
  end

  def count_on(grid) do
    grid
    |> Enum.filter(fn {_coord, on?} -> on? end)
    |> length()
  end

  defp parse_instruction(instruction) do
    [from, to] = parse_range(instruction)

    cond do
      String.starts_with?(instruction, "turn on") -> {:on, from, to}
      String.starts_with?(instruction, "turn off") -> {:off, from, to}
      true -> {:toggle, from, to}
    end
  end

  defp parse_range(instruction) do
    Regex.scan(~r/\d+/, instruction)
    |> List.flatten()
    |> Enum.map(&String.to_integer/1)
    |> Enum.chunk_every(2)
    |> Enum.map(&List.to_tuple/1)
  end

  defp apply_to_grid({:on, to, from}, grid) do
    apply_to_lights(grid, to, from, fn _ -> true end)
  end

  defp apply_to_grid({:off, to, from}, grid) do
    apply_to_lights(grid, to, from, fn _ -> false end)
  end

  defp apply_to_grid({:toggle, to, from}, grid) do
    apply_to_lights(grid, to, from, fn onness -> not onness end)
  end

  defp apply_to_lights(grid, to, from, fun) do
    lights_between(to, from)
    |> Enum.reduce(grid, fn coord, grid ->
      state = Map.fetch!(grid, coord)

      Map.put(grid, coord, fun.(state))
    end)
  end

  defp lights_between({x1, y1}, {x2, y2}) do
    for x <- x1..x2, y <- y1..y2, do: {x, y}
  end
end
