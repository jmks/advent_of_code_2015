defmodule Day04.StockingStufferTest do
  use ExUnit.Case, async: true

  import Day04.StockingStuffer

  @tag :slow
  test "decimal/1" do
    assert decimal("abcdef") == 609043
    assert decimal("pqrstuv") == 1048970
  end
end
