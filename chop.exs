defmodule Chop do
  def guess(number, range = first..last) when first < last do
    guess(number, middle(first, last), range)
  end

  def guess(number, first..last) do
    guess(number, middle(last, first), last..first)
  end

  def guess(number, guess, _) when number === guess do
    print guess
    guess
  end

  def guess(number, guess, _..last) when div(number, guess) > 0 do
    print guess
    guess(number, middle(guess, last), guess..last)
  end

  def guess(number, guess, first.._) when div(number, guess) == 0 do
    print guess
    guess(number, middle(first, guess), first..guess)
  end

  def middle(first, last) do
    first + div(last - first, 2)
  end

  def print(guess), do: IO.puts "Is it #{guess}?"
end
