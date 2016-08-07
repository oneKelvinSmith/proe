defmodule Issues.CLI do
  import Issues.TableFormatter, only: [print_table_for_columns: 2]

  @count  4
  @api    Issues.GithubIssues.Github
  @system System

  @moduledoc """
  Handle the command line parsing and the dispatch to
  the various functions that end up generating a
  table of the last _n_ issues in a gihub project
  """

  @doc "Entry point for CLI"
  def main(argv) do
    argv
    |> parse_args
    |> process
  end

  @doc """
  `argv` can be -h or --help, which returns :help.

  Otherwise it is a gihub user name, project name,
  and (optionally) the number of entries to format.

  Return a tuple of `{user, project, count}`, or
  `:help` if help was given.
  """
  def parse_args(argv) do
    parse = OptionParser.parse(
      argv,
      switches: [help: :boolean],
      aliases: [h: :help]
    )
    case parse do
      {[help: true], _, _} ->
        :help
      {_, [user, project, count], _} ->
        {user, project, String.to_integer(count)}
      {_, [user, project], _} ->
        {user, project, @count}
    end
  end

  def process(query, options \\ [])

  def process(:help, _options) do
    IO.puts """
    usage: issues <user> <project> [ count | #{@count} ]
    """
  end

  def process({user, project, count}, options) do
    api    = options[:api]    || @api
    system = options[:system] || @system

    api.fetch(user, project)
    |> decode_response(system)
    |> sort_into_ascending_order
    |> Enum.take(count)
    |> print_table_for_columns(["number", "created_at", "title"])
  end

  def decode_response({:ok, body}, _system), do: body

  def decode_response({:error, error}, system) do
    message = error["message"]
    IO.puts "Error fetching from Github: #{message}"
    system.halt(2)
  end

  def sort_into_ascending_order(issues) do
    Enum.sort issues, &(&1["created_at"] <= &2["created_at"])
  end
end
