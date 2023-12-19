defmodule AdventOfCode.DayOneTest do
  use ExUnit.Case

  describe "Day One - part one" do
    test "sums a list of strings" do
      assert 32 = DayOne.PartOne.execute(["he1l0", "he2lo"])
      assert 145 = DayOne.PartOne.execute(["5e1l5", "9dowkd1414910"])
    end

    test "supports file input" do
      assert 55971 = DayOne.PartOne.execute("test/day_one/input.txt")
    end
  end

  describe "Day One - part two" do
    test "supports spelled out numbers" do
      assert 22 = DayOne.PartTwo.execute(["2"])
      assert 29 = DayOne.PartTwo.execute(["two1nine"])
      assert 83 = DayOne.PartTwo.execute(["eightwothree"])
      assert 13 = DayOne.PartTwo.execute(["abcone2threexyz"])
      assert 24 = DayOne.PartTwo.execute(["xtwone3four"])
      assert 42 = DayOne.PartTwo.execute(["4nineeightseven2"])
      assert 14 = DayOne.PartTwo.execute(["zoneight234"])
      assert 76 = DayOne.PartTwo.execute(["7pqrstsixteen"])

      assert 90 = DayOne.PartTwo.execute(["zoneight234", "7pqrstsixteen"])
      assert 72 = DayOne.PartTwo.execute(["mdxdlh5six5nqfld9bqzxdqxfour", "one98hmlkqlnbrnbzxjd"])
      assert 33 = DayOne.PartTwo.execute(["gdgj3f"])
      assert 11 = DayOne.PartTwo.execute(["gdgjonef"])
      assert 21 = DayOne.PartTwo.execute(["2fourfourone"])

      assert 281 =
               DayOne.PartTwo.execute([
                 "two1nine",
                 "eightwothree",
                 "abcone2threexyz",
                 "xtwone3four",
                 "4nineeightseven2",
                 "zoneight234",
                 "7pqrstsixteen"
               ])

      assert 62 = DayOne.PartTwo.execute(["sixjmbljdchjsrs3bvvnzqcqmjcm3eightwoc"])
      assert 83 = DayOne.PartTwo.execute(["eighthree"])
      assert 79 = DayOne.PartTwo.execute(["sevenine"])

      assert 39 = DayOne.PartTwo.execute(["threefivefour9"])
      assert 43 = DayOne.PartTwo.execute(["fourfourpsckl47xdbncvndrthree"])
      assert 95 = DayOne.PartTwo.execute(["9qfivedrpfmxfbskhfstwofivergqcg"])
    end

    test "supports file input" do
      assert 54719 = DayOne.PartTwo.execute("test/day_one/input.txt")
    end
  end
end
