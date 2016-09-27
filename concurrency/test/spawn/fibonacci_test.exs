defmodule FibonacciTest do
  use ExUnit.Case

  describe "solve/1" do
    test "uses a scheduler to generate a fibonnaci sequence" do
      solver = spawn Fibonacci, :solve, [self]

      receive do
        {:ready, pid} ->
          assert pid == solver
      end

      send solver, {:fib, 10, self}

      receive do
        {:answer, number, result, ^solver} ->
          assert number == 10
          assert result == 55
        :else ->
          flunk "does not use scheduler appropriately"
      end
    end
  end
end
