defmodule Day06.FireHazard do
  defmodule Lights do
    defstruct [:grid, :on, :off, :toggle]

    def new(switch_type \\ :on_off, size \\ 1_000) do
      case switch_type do
        :on_off ->
          grid =
            for x <- 0..size, y <- 0..size, into: %{} do
              {{x, y}, false}
            end

          %__MODULE__{
            grid: grid,
            on: fn _ -> true end,
            off: fn _ -> false end,
            toggle: fn state -> not state end
          }

        :brightness ->
          grid =
            for x <- 0..size, y <- 0..size, into: %{} do
              {{x, y}, 0}
            end

          %__MODULE__{
            grid: grid,
            on: fn b -> b + 1 end,
            off: fn b -> Enum.max([0, b - 1]) end,
            toggle: fn b -> b + 2 end
          }
      end
    end
  end

  def parse_instructions(instructions) do
    instructions
    |> String.split("\n", trim: true)
    |> Enum.map(&parse_instruction/1)
  end

  def apply_instruction(lights, instructions) when is_list(instructions) do
    new_grid =
      Enum.reduce(instructions, lights.grid, fn {action, to, from}, grid ->
        lights_between(to, from)
        |> Enum.reduce(grid, fn coord, grid ->
          state = Map.fetch!(grid, coord)

          new_state = Map.fetch!(lights, action).(state)

          Map.put(grid, coord, new_state)
        end)
      end)

    %{lights | grid: new_grid}
  end

  def count_on(lights) do
    lights.grid
    |> Enum.map(fn
      {_coord, true} -> 1
      {_coord, false} -> 0
      {_coord, brightness} when is_integer(brightness) -> brightness
    end)
    |> Enum.sum()
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

  defp lights_between({x1, y1}, {x2, y2}) do
    for x <- x1..x2, y <- y1..y2, do: {x, y}
  end
end
