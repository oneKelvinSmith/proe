numbers = [1, 2, 3, 4]

IO.inspect Enum.map numbers, fn x -> x + 2 end
IO.inspect Enum.map numbers, &(&1 + 2)

Enum.each numbers, fn x -> IO.inspect x end
Enum.each numbers, &IO.inspect(&1)
