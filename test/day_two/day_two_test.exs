defmodule AdventOfCode.DayTwoTest do
  use ExUnit.Case

  describe "Day Two - part one" do
    @cube_set %{red: 12, green: 13, blue: 14}

    test "returns the game ID if it is possible given set of cubes" do
      assert 1 =
               DayTwo.PartOne.execute(
                 ["Game 1: 3 blue, 4 red; 1 red, 2 green, 6 blue; 2 green"],
                 @cube_set
               )

      assert 2 =
               DayTwo.PartOne.execute(
                 ["Game 2: 1 blue, 2 green; 3 green, 4 blue, 1 red; 1 green, 1 blue"],
                 @cube_set
               )

      assert 5 =
               DayTwo.PartOne.execute(
                 ["Game 5: 6 red, 1 blue, 3 green; 2 blue, 1 red, 2 green"],
                 @cube_set
               )
    end

    test "returns 0 if the game is not possible with the given set of cubes" do
      assert 0 =
               DayTwo.PartOne.execute(
                 ["Game 3: 8 green, 6 blue, 20 red; 5 blue, 4 red, 13 green; 5 green, 1 red"],
                 @cube_set
               )

      assert 0 =
               DayTwo.PartOne.execute(
                 ["Game 4: 1 green, 3 red, 6 blue; 3 green, 6 red; 3 green, 15 blue, 14 red"],
                 @cube_set
               )
    end

    test "returns the sum of possible game IDs" do
      games = [
        "Game 1: 3 blue, 4 red; 1 red, 2 green, 6 blue; 2 green",
        "Game 2: 1 blue, 2 green; 3 green, 4 blue, 1 red; 1 green, 1 blue",
        "Game 3: 8 green, 6 blue, 20 red; 5 blue, 4 red, 13 green; 5 green, 1 red",
        "Game 4: 1 green, 3 red, 6 blue; 3 green, 6 red; 3 green, 15 blue, 14 red",
        "Game 5: 6 red, 1 blue, 3 green; 2 blue, 1 red, 2 green"
      ]

      assert 8 = DayTwo.PartOne.execute(games, @cube_set)
    end

    test "supports file input" do
      assert 1_867 = DayTwo.PartOne.execute("test/day_two/input.txt", @cube_set)
    end
  end

  describe "Day Two - part two" do
    test "returns the product of largest number of game cube colors" do
      assert 48 =
               DayTwo.PartTwo.execute(["Game 1: 3 blue, 4 red; 1 red, 2 green, 6 blue; 2 green"])

      assert 12 =
               DayTwo.PartTwo.execute([
                 "Game 2: 1 blue, 2 green; 3 green, 4 blue, 1 red; 1 green, 1 blue"
               ])

      assert 1_560 =
               DayTwo.PartTwo.execute([
                 "Game 3: 8 green, 6 blue, 20 red; 5 blue, 4 red, 13 green; 5 green, 1 red"
               ])

      assert 630 =
               DayTwo.PartTwo.execute([
                 "Game 4: 1 green, 3 red, 6 blue; 3 green, 6 red; 3 green, 15 blue, 14 red"
               ])

      assert 36 =
               DayTwo.PartTwo.execute(["Game 5: 6 red, 1 blue, 3 green; 2 blue, 1 red, 2 green"])
    end

    test "supports file input" do
      assert 84_538 = DayTwo.PartTwo.execute("test/day_two/input.txt")
    end
  end
end
