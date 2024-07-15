defmodule Day06.FireHazardTest do
  use ExUnit.Case, async: true

  import Day06.FireHazard

  @tag :slow
  test "turning lights on" do
    grid =
      new(1_000)
      |> apply_instruction(parse_instructions("turn on 0,0 through 999,999"))

    assert count_on(grid) == 1_000_000
  end

  test "turn on, off and toggle" do
    grid =
      new(3)
      |> apply_instruction(
        parse_instructions("""
        turn on 0,0 through 0,2
        turn off 1,0 through 1,2
        turn on 2,0 through 2,2
        """)
      )

    assert count_on(grid) == 6

    grid =
      apply_instruction(
        grid,
        parse_instructions("""
        turn off 0,0 through 0,2
        toggle 1,0 through 1,2
        toggle 2,0 through 2,2
        """)
      )

    assert count_on(grid) == 3
  end

  test "parse_instructions/1" do
    assert parse_instructions("turn on 0,0 through 999,999") == [{:on, {0, 0}, {999, 999}}]
    assert parse_instructions("toggle 0,0 through 999,0") == [{:toggle, {0, 0}, {999, 0}}]

    assert parse_instructions("""
           turn on 0,0 through 0,2
           turn off 1,0 through 1,2
           turn on 2,0 through 2,2
           """) == [
             {:on, {0, 0}, {0, 2}},
             {:off, {1, 0}, {1, 2}},
             {:on, {2, 0}, {2, 2}}
           ]
  end
end
