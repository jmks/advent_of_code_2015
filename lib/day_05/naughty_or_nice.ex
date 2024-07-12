defmodule Day05.NaughtyOrNice do
  def nice?(word) do
    vowel_count(word) >= 3 and double_letter?(word) and not naughty_string?(word)
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
end
