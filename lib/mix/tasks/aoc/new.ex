defmodule Mix.Tasks.Aoc.New do
  use Mix.Task

  def run([day_number, desc]) do
    day = Input.stringified_day(day_number)

    lib_module =
      Enum.join(
        [
          snake_to_camel(day),
          snake_to_camel(desc)
        ],
        "."
      )

    create_file("lib/#{day}", "input", "")
    create_file("lib/#{day}", "README", "Day #{day_number}")

    create_file("lib/#{day}", "#{desc}.ex", """
    defmodule #{lib_module} do
    end
    """)

    create_file("test/#{day}", "#{desc}_test.exs", """
    defmodule #{lib_module}Test do
      use ExUnit.Case, async: true

      import #{lib_module}

      test "the truth" do
        assert true
      end
    end
    """)
  end

  defp create_file(path, filename, contents) do
    File.mkdir_p(path)
    File.write!(Path.join(path, filename), contents, [:write])
  end

  defp snake_to_camel(str) do
    str
    |> String.split("_")
    |> Enum.map(&String.capitalize/1)
    |> Enum.join("")
  end
end
