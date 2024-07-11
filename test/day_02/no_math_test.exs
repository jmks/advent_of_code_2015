defmodule Day02.NoMathTest do
  use ExUnit.Case, async: true

  import Day02.NoMath

  describe "wrapping_area/1" do
    assert wrapping_area("2x3x4") == 58
    assert wrapping_area("1x1x10") == 43
  end

  describe "ribbon_length/1" do
    assert ribbon_length("2x3x4") == 34
    assert ribbon_length("1x1x10") == 14
  end
end
