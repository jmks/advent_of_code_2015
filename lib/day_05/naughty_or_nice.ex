defmodule Day05.NaughtyOrNice do
  def nice?(word) do
    vowel_count(word) >= 3 and double_letter?(word) and not naughty_string?(word)
  end

  def new_nice?(word) do
    pair_appearing_twice?(word) and letter_sandwich?(word)
  end

  def vowel_count(word) do
    letters = Enum.frequencies(String.codepoints(word))

    vowels = ~w(a e i o u)
    Enum.reduce(letters, 0, fn {letter, count}, acc ->
      if letter in vowels do
        count + acc
      else
        acc
      end
    end)
  end

  def double_letter?(word) do
    word
    |> String.codepoints()
    |> Enum.chunk_every(2, 1)
    |> Enum.any?(fn
      [a, a] -> true
      _ -> false
    end)
  end

  def naughty_string?(word) do
    word
    |> String.codepoints()
    |> Enum.chunk_every(2, 1)
    |> Enum.any?(fn
      ["a", "b"] -> true
      ["c", "d"] -> true
      ["p", "q"] -> true
      ["x", "y"] -> true
      _ -> false
    end)
  end

  def pair_appearing_twice?(word) do
    word
    |> String.codepoints()
    |> Enum.chunk_every(2, 1, :discard)
    |> remove_repeats()
    |> Enum.group_by(fn [a, b] -> a <> b end)
    |> Enum.any?(fn {_pair, pairs} ->
      length(pairs) >= 2
    end)
  end

  def letter_sandwich?(word) do
    word
    |> String.codepoints()
    |> Enum.chunk_every(3, 1, :discard)
    |> Enum.any?(fn
      [a, _, a] -> true
      _ -> false
    end)
  end

  defp remove_repeats(words) do
    do_remove_repeats(words, [])
  end

  defp do_remove_repeats([], words), do: Enum.reverse(words)

  defp do_remove_repeats([word, word | rest], words) do
    do_remove_repeats(rest, [word | words])
  end

  defp do_remove_repeats([word | rest], words) do
    do_remove_repeats(rest, [word | words])
  end
end
