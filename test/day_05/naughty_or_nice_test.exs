defmodule Day05.NaughtyOrNiceTest do
  use ExUnit.Case, async: true

  import Day05.NaughtyOrNice

  test "nice?/1" do
    assert nice?("ugknbfddgicrmopn")
    assert nice?("aaa")
    assert nice?("aeioo")
    refute nice?("jchzalrnumimnmhp")
    refute nice?("haegwjzuvuyypxyu")
    refute nice?("dvszwmarrgswjxmb")
  end

  test "vowel_count/1" do
    assert vowel_count("ugknbfddgicrmopn") >= 3
    assert vowel_count("aaa") == 3
    assert vowel_count("dvszwmarrgswjxmb") == 1
  end

  test "double_letter?/1" do
    assert double_letter?("aa")
    assert double_letter?("abb")
    refute double_letter?("abc")
    refute double_letter?("aba")
    refute double_letter?("jchzalrnumimnmhp")
  end

  test "naughty_string?/1" do
    assert naughty_string?("ab")
    assert naughty_string?("cabc")
  end
end
