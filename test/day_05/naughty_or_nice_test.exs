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

  test "pair_appearing_twice?/1" do
    assert pair_appearing_twice?("xyxy")
    assert pair_appearing_twice?("aabcdefgaa")
    refute pair_appearing_twice?("aaa")
    assert pair_appearing_twice?("xxxxx")
  end

  test "letter_sandwich?/1" do
    assert letter_sandwich?("xyx")
    assert letter_sandwich?("abcdefeghi")
    assert letter_sandwich?("aaa")
    refute letter_sandwich?("aab")
  end

  test "new_nice?/1" do
    assert new_nice?("qjhvhtzxzqqjkmpb")
    assert new_nice?("xxyxx")
    refute new_nice?("uurcxstgmygtbstg")
    refute new_nice?("ieodomkazucvgmuy")
  end
end
