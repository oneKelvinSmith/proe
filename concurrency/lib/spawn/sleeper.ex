defmodule Sleeper do
  import :timer, only: [ sleep: 1 ]

  def a_simple_death(parent) do
    send parent, {self(), :death_is_imminent}
    exit :death
  end

  def a_blaze_of_glory(parent) do
    send parent, {self(), :not_going_quietly}
    raise "the_flames_of_legacy"
  end

  def link do
    run(&spawn_link/3, :a_simple_death)
  end

  def link_with_exception do
    run(&spawn_link/3, :a_blaze_of_glory)
  end

  def monitor do
    run(&spawn_monitor/3, :a_simple_death)
  end

  def monitor_with_exception do
    run(&spawn_monitor/3, :a_blaze_of_glory)
  end

  def run(spawner, child_function) do
    Process.flag(:trap_exit, true)

    child = spawner.(Sleeper, child_function, [self()])

    sleep 500

    listen(child)
  end

  def listen(child) do
    receive do
      {^child, message} ->
        IO.puts "Child reported #{inspect message}"
        listen(child)
      {:EXIT, ^child, :death} ->
        IO.puts "Child died"
        listen(child)
      {:EXIT, _pid, {%RuntimeError{}, _trace}} ->
        IO.puts "Child was immolated"
        listen(child)
    after 500 ->
        IO.puts "Nothing more to report"
    end
  end
end
