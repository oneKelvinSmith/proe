defmodule PrimeTest do
  use ExUnit.Case

  test "upto/1 should return all prime numbers upto 2" do
    assert Prime.upto(2) == [2]
  end

  test "upto/1 should return all prime numbers upto given integer" do
    primes = [2, 3, 5, 7, 11, 13, 17, 19, 23, 29, 31, 37, 41]
    assert Prime.upto(42) == primes
  end
end
