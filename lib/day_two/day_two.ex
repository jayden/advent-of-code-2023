defmodule DayTwo do
  defmodule PartOne do
    def execute(inputs, cubes) when is_list(inputs) do
      Enum.reduce(inputs, 0, fn input, sum ->
        sum + maybe_get_game_id(input, cubes)
      end)
    end

    def execute(file_path, cubes) do
      {:ok, content} = File.read(file_path)

      content
      |> String.split("\n")
      |> execute(cubes)
    end

    defp maybe_get_game_id(input, %{red: red, green: green, blue: blue}) do
      [name, game] = String.split(input, ":")
      rounds = String.split(game, ";")

      Enum.any?(rounds, fn round ->
        round_cubes = String.split(round, ",")
        red_count = red - DayTwo.get_cube_count(round_cubes, "red")
        green_count = green - DayTwo.get_cube_count(round_cubes, "green")
        blue_count = blue - DayTwo.get_cube_count(round_cubes, "blue")

        red_count < 0 or green_count < 0 or blue_count < 0
      end)
      |> if do
        0
      else
        {game_id, _rem} = name |> String.replace(~r/[^\d]/, "") |> Integer.parse()
        game_id
      end
    end
  end

  defmodule PartTwo do
    @spec execute(binary() | maybe_improper_list()) :: any()
    def execute(inputs) when is_list(inputs) do
      Enum.reduce(inputs, 0, fn input, sum ->
        sum + get_cube_product(input)
      end)
    end

    def execute(file_path) do
      {:ok, content} = File.read(file_path)

      content
      |> String.split("\n")
      |> execute()
    end

    defp get_cube_product(input) do
      [_name, game] = String.split(input, ":")
      rounds = String.split(game, ";")

      %{red: red, green: green, blue: blue} =
        Enum.reduce(rounds, %{red: 1, green: 1, blue: 1}, fn round, acc ->
          round_cubes = String.split(round, ",")
          red_count = get_larger_count(round_cubes, Map.get(acc, :red), "red")
          green_count = get_larger_count(round_cubes, Map.get(acc, :green), "green")
          blue_count = get_larger_count(round_cubes, Map.get(acc, :blue), "blue")

          acc
          |> Map.put(:red, red_count)
          |> Map.put(:green, green_count)
          |> Map.put(:blue, blue_count)
        end)

      red * green * blue
    end

    defp get_larger_count(round_cubes, current_count, color) do
      count = DayTwo.get_cube_count(round_cubes, color)

      if count > current_count do
        count
      else
        current_count
      end
    end
  end

  def get_cube_count(round_cubes, color) do
    Enum.reduce(round_cubes, 0, fn cube, count ->
      if String.contains?(cube, color) do
        {cube_count, _rem} =
          String.split(cube, color, trim: true)
          |> List.first()
          |> String.trim()
          |> Integer.parse()

        count + cube_count
      else
        count
      end
    end)
  end
end
