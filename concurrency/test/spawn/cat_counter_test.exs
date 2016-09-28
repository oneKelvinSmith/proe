defmodule CatCounterTest do
  use ExUnit.Case

  describe "count_cats/1" do
    test "returns the number of occurrances of the word cat in a file" do
      assert CatCounter.count("test/fixtures/cats/42.txt") == 42
    end

    test "returns the number of occurrances of the word cat in a file with other words" do
      assert CatCounter.count("test/fixtures/cats/21.txt") == 21
    end
  end
end
