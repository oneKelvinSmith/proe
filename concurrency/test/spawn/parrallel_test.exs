defmodule ParrallelTest do
  use ExUnit.Case

  describe "pmap/2" do
    test "parrallel map works" do
      result = Parrallel.pmap 1..10, &(&1 * &1)

      assert result == [1,4,9,16,25,36,49,64,81,100]
    end
  end
end
