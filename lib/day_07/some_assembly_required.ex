defmodule Day07.SomeAssemblyRequired do
  def parse_circuit(connections) do
    connections
    |> String.split("\n", trim: true)
    |> Enum.map(&parse/1)
  end

  def run(circuit) when is_list(circuit) do
    {initial_signals, gates} =
      Enum.split_with(circuit, fn
        {:signal, {:wire, _}, {:wire, _}} -> false
        element -> elem(element, 0) == :signal
      end)

    signals =
      initial_signals
      |> Enum.reduce(%{}, fn {:signal, signal, {:wire, wire}}, acc ->
        Map.put(acc, wire, signal)
      end)

    do_run(signals, gates)
  end

  defp parse(connection) do
    [input, output] = String.split(connection, " -> ", parts: 2, trim: true)

    out = part(output)

    case String.split(input, " ", trim: true) do
      [signal] ->
        {:signal, part(signal), out}

      ["NOT", value] ->
        {:gate, :not, part(value), out}

      [left, "AND", right] ->
        {:gate, :and, {part(left), part(right)}, out}

      [left, "OR", right] ->
        {:gate, :or, {part(left), part(right)}, out}

      [left, "LSHIFT", right] ->
        {:gate, :lshift, {part(left), part(right)}, out}

      [left, "RSHIFT", right] ->
        {:gate, :rshift, {part(left), part(right)}, out}
    end
  end

  defp part(desc) do
    if String.match?(desc, ~r/^[a-z]+$/) do
      {:wire, desc}
    else
      String.to_integer(desc)
    end
  end

  defp do_run(signals, []), do: signals

  defp do_run(signals, gates) do
    {emitting_gates, non_emitting_gates} = Enum.split_with(gates, fn
      {:signal, input, _output} -> signals?(signals, input)
      {:gate, :not, input, _output} -> signals?(signals, input)
      {:gate, _op, {left, right}, _output} -> signals?(signals, left, right)
    end)

    new_signals = Enum.reduce(emitting_gates, signals, fn gate, signals_acc ->
      eval_gate(signals_acc, gate)
    end)

    do_run(new_signals, non_emitting_gates)
  end

  defp signals?(signals, {:wire, wire}), do: Map.has_key?(signals, wire)
  defp signals?(_signals, _value), do: true

  defp signals?(signals, {:wire, left}, {:wire, right}), do: Map.has_key?(signals, left) and Map.has_key?(signals, right)
  defp signals?(signals, {:wire, left}, _value), do: Map.has_key?(signals, left)
  defp signals?(signals, _value, {:wire, right}), do: Map.has_key?(signals, right)

  defp eval_gate(signals, {:signal, input, {:wire, out}}) do
    Map.put(signals, out, get_value(signals, input))
  end

  defp eval_gate(signals, {:gate, :not, input, {:wire, out}}) do
    # bitwise complement
    value = 2**16 - 1 - get_value(signals, input)

    Map.put(signals, out, value)
  end

  defp eval_gate(signals, {:gate, op, {left, right}, {:wire, out}}) do
    value = bitwise(op, get_value(signals, left), get_value(signals, right))

    Map.put(signals, out, value)
  end

  defp get_value(signals, {:wire, wire}), do: Map.fetch!(signals, wire)
  defp get_value(_signals, value), do: value

  defp bitwise(:and, left, right), do: Bitwise.band(left, right)
  defp bitwise(:or, left, right), do: Bitwise.bor(left, right)
  defp bitwise(:lshift, left, right), do: Bitwise.bsl(left, right)
  defp bitwise(:rshift, left, right), do: Bitwise.bsr(left, right)
end
