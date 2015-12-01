buzz = fn
  (0, 0, _) -> "FizzBuzz"
  (0, _, _) -> "Buzz"
  (_, 0, _) -> "Fizz"
  (_, _, number) -> number
end

fizz = fn (number) ->
  buzz.(rem(number, 3), rem(number, 5), number)
end

IO.puts fizz.(10)
IO.puts fizz.(11)
IO.puts fizz.(12)
IO.puts fizz.(13)
IO.puts fizz.(14)
IO.puts fizz.(15)
IO.puts fizz.(16)
