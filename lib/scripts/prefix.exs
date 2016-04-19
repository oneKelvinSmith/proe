prefix = fn prefix ->
  fn word ->
    "#{prefix} #{word}"
  end
end

mrs = prefix.("Mrs")
IO.puts mrs.("Smith")
IO.puts prefix.("Elixir").("Rocks")
