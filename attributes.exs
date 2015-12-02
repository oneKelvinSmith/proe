defmodule Example do
  @author "Dave Thomas"
  def get_author do
    @author
  end
end

IO.puts "Elixir was written by #{Example.get_author}"

defmodule Example do
  @attr "one"
  def first, do: @attr
  @attr "two"
  def second, do: @attr
end

IO.puts "#{Example.first} #{Example.second}"
