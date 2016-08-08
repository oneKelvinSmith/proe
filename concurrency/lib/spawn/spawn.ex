defmodule Spawn do
  def greet do
    receive do
      {sender, message} ->
        send sender, {:ok, "Hello, #{message}"}
        greet
    end
  end
end
