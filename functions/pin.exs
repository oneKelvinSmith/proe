defmodule Greeter do
  def for(name, greeting) do
    fn
      (^name) -> "#{greeting} #{name}"
      (_)     -> "I don't know you"
    end
  end
end

kelvin_greeter = Greeter.for("Kelvin", "Hello!")

IO.puts kelvin_greeter.("Kelvin")
IO.puts kelvin_greeter.("Anyone else")
