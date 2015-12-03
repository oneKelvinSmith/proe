defmodule Libraries do
  def to_string(float) when is_float(float) do
    :io.format("~.2f~n", float)
  end

  def get_env(variable) do
    System.get_env(variable)
  end

  def extension(filename) do
    Path.extname filename
  end

  def cwd do
    System.cwd
  end

  def cmd(tool, command) do
    System.cmd tool, [command]
  end
end
