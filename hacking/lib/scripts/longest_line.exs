"/usr/share/dict/words"
|> File.read!
|> IO.puts
|> String.split
|> Enum.max_by(&String.length/1)
