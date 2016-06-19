defmodule ParseTest do
  use ExUnit.Case

  test "number/1 returns parses an integer correnctly" do
    assert Parse.number('123') == 123
  end

  test "number/1 returns parses a negative integer correnctly" do
    assert Parse.number('-123') == -123
  end

  test "number/1 returns parses a positive integer correnctly" do
    assert Parse.number('+123') == 123
  end

  test "raises exeption when char list is not a valid number" do
    assert_raise RuntimeError, "Invalid digit 'a'", fn ->
      Parse.number '+a'
    end
  end

  test "ascii?/1 returns true when given a char list contains only ASCII character" do
    assert Parse.ascii?('A valid ASCII string that is totally 1337') == true
  end

  test "ascii?/1 returns false when given an empty list" do
    assert Parse.ascii?('') == false
  end

  test "ascii?/1 returns false when given non-ASCII characters" do
    assert Parse.ascii?('Þórr was here on hunresdæg') == false
  end

  test "ascii?/1 returns false when the last character is non-ASCII" do
    assert Parse.ascii?('Everything was fine until...Ω') == false
  end
end
