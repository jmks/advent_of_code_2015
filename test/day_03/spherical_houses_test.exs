defmodule Day03.SphericalHousesTest do
  use ExUnit.Case, async: true

  import Day03.SphericalHouses

  describe "unique_houses/1" do
    test "unique" do
      assert unique_houses(">") == 2
    end

    test "overlaps starting house" do
      assert unique_houses("^>v<") == 4
    end

    test "overlaps only two houses" do
      assert unique_houses("^v^v^v^v^v") == 2
    end
  end
end
