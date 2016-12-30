to_process = List.duplicate(37, 20)

Enum.each 1..10, fn num_processes ->
  {time, result} =
    :timer.tc(
      Scheduler, :run,
      [num_processes, Fibonacci, :solve, to_process]
    )

  if num_processes == 1 do
    IO.puts inspect result
    IO.puts "\n #  time (s)"
  end

  :io.format "~2B   ~.2f~n", [num_processes, time/1000000.0]
end
