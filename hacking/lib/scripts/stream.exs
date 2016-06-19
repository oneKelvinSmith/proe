[1, 2, 3, 4]
|> Stream.map(&(&1 * &1))
|> Stream.map(&(&1 + 1))
|> Stream.filter(fn x -> rem(x, 2) == 1 end)
|> Enum.to_list
|> IO.inspect

"/usr/share/dict/words"
|> File.stream!
|> Enum.max_by(&String.length/1)
|> IO.puts
