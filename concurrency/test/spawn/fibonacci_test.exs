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
        :failure ->
          flunk "does not use scheduler appropriately"
      end
    end

    test "exits when asked to shutdown" do
      trap = Process.flag(:trap_exit, true)

      solver = spawn_link Fibonacci, :solve, [self]

      receive do
        {:ready, pid} ->
          assert pid == solver
      end

      send solver, {:shutdown}

      receive do
        {:EXIT, ^solver, exit_type} ->
          assert exit_type == :normal
        :failure ->
          flunk "does not exit as expected"
      end

      Process.flag(:trap_exit, trap)
    end
  end
end
