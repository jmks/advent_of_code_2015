defmodule Day01.NotQuiteLispTest do
  use ExUnit.Case, async: true

  import Day01.NotQuiteLisp

  test "goes up and down" do
    assert follow("(())") == 0
    assert follow("()()") == 0
  end

  test "ascends" do
    assert follow("(((") == 3
    assert follow("(()(()(") == 3
    assert follow("))(((((") == 3
  end

  test "descends" do
    assert follow("())") == -1
    assert follow("))(") == -1
    assert follow(")))") == -3
    assert follow(")())())") == -3
  end

  describe "enter_basement/1" do
    test "on the first character" do
      assert enter_basement(")") == 1
    end

    test "after a few characters" do
      assert enter_basement("()())") == 5
    end
  end
end
