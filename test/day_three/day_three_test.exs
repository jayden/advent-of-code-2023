defmodule AdventOfCode.DayThreeTest do
  use ExUnit.Case

  describe "Day three - part one" do
    test "returns numbers next to symbol" do
      assert 467 = DayThree.PartOne.execute(["467&.114.."])
      assert 467 = DayThree.PartOne.execute(["&467..114.."])
      assert 114 = DayThree.PartOne.execute(["467.&114.."])
      assert 114 = DayThree.PartOne.execute(["..114&.467"])
      assert 114 = DayThree.PartOne.execute(["467...114&"])
      assert 0 = DayThree.PartOne.execute([".....+.58."])
    end

    test "returns number if it is diagonal to symbol in next line" do
      assert 467 = DayThree.PartOne.execute(["467..114..", "...*...... "])
    end

    test "returns number if it is below a symbol in previous line" do
      assert 35 = DayThree.PartOne.execute(["...*......", "..35..633."])
    end

    test "returns number if it is diagonal to symbol in previous line" do
      assert 35 = DayThree.PartOne.execute([".*........", "..35..633."])
      assert 633 = DayThree.PartOne.execute([".........&", "..35..633."])
    end

    test "returns sum of numbers without duplicates" do
      line = [
        "...*.........960=.....609...372..516....797*652...179......337.........*864..457..315.....207..............177..666.........................",
        ".456..283..................*.............-.........*...51...........798.....................................#...........796.880............."
      ]

      assert 5255 = DayThree.PartOne.execute(line)
    end

    test "handles multiple lines" do
      list = [
        "467..114..",
        "...*......",
        "..35..633.",
        "......#...",
        "617*......",
        ".....+.58.",
        "..592.....",
        "......755.",
        "...$.*....",
        ".664.598.."
      ]

      assert 4361 = DayThree.PartOne.execute(list)
    end

    test "supports file input" do
      assert 527_369 = DayThree.PartOne.execute("test/day_three/input.txt")
    end
  end

  describe "Day three - part two" do
    test "sums product of gears (*) with only two adjacent numbers" do
      list = [
        "467..114..",
        "...*......",
        "..35..633.",
        "......#...",
        "617*......",
        ".....+.58.",
        "..592.....",
        "......755.",
        "...$.*....",
        ".664.598.."
      ]

      assert 467_835 = DayThree.PartTwo.execute(list)
    end

    test "supports file input" do
      assert 73_074_886 = DayThree.PartTwo.execute("test/day_three/input.txt")
    end
  end
end
