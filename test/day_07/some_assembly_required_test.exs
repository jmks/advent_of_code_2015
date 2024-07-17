defmodule Day07.SomeAssemblyRequiredTest do
  use ExUnit.Case, async: true

  import Day07.SomeAssemblyRequired

  describe "parse_circuit/1" do
    test "parses a signal to a wire" do
      assert parse_circuit("123 -> x") == [{:signal, 123, {:wire, "x"}}]
      assert parse_circuit("456 -> y") == [{:signal, 456, {:wire, "y"}}]
    end

    test "parses wire to a wire" do
      assert parse_circuit("lx -> ly") == [{:signal, {:wire, "lx"}, {:wire, "ly"}}]
    end

    test "parses AND gate" do
      assert parse_circuit("x AND y -> d") == [
               {:gate, :and, {{:wire, "x"}, {:wire, "y"}}, {:wire, "d"}}
             ]
    end

    test "parses OR gate" do
      assert parse_circuit("x OR y -> e") == [
               {:gate, :or, {{:wire, "x"}, {:wire, "y"}}, {:wire, "e"}}
             ]
    end

    test "parses LSHIFT/RSHIFT" do
      assert parse_circuit("x LSHIFT 2 -> f") == [
               {:gate, :lshift, {{:wire, "x"}, 2}, {:wire, "f"}}
             ]

      assert parse_circuit("y RSHIFT 2 -> g") == [
               {:gate, :rshift, {{:wire, "y"}, 2}, {:wire, "g"}}
             ]
    end

    test "parses NOT gate" do
      assert parse_circuit("NOT x -> h") == [{:gate, :not, {:wire, "x"}, {:wire, "h"}}]
      assert parse_circuit("NOT y -> i") == [{:gate, :not, {:wire, "y"}, {:wire, "i"}}]
    end
  end

  describe "run/1" do
    test "only signals" do
      result =
        parse_circuit("""
        123 -> x
        456 -> y
        """)
        |> run()

      assert Map.fetch!(result, "x") == 123
      assert Map.fetch!(result, "y") == 456
    end

    test "signal from another wire" do
      result = parse_circuit("""
      lx -> ly
      123 -> lx
      """) |> run()

      assert Map.fetch!(result, "ly") == 123
    end

    test "single gate" do
      result =
        parse_circuit("""
        123 -> x
        456 -> y
        NOT x -> z
        """)
        |> run()

      assert Map.fetch!(result, "x") == 123
      assert Map.fetch!(result, "y") == 456
      assert Map.fetch!(result, "z") == (2**16 - 1) - 123
    end

    test "a few steps" do
      result =
        parse_circuit("""
        123 -> x
        456 -> y
        x AND y -> d
        x OR y -> e
        x LSHIFT 2 -> f
        y RSHIFT 2 -> g
        NOT x -> h
        NOT y -> i
        """)
        |> run()

      assert result == %{
        "d" => 72,
        "e" => 507,
        "f" => 492,
        "g" => 114,
        "h" => 65412,
        "i" => 65079,
        "x" => 123,
        "y" => 456,
      }
    end
  end
end
