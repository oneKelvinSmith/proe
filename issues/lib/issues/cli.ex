defmodule Issues.CLI do
  @default_count 4
  @default_api Issues.GithubIssues.Github

  @moduledoc """
  Handle the command line parsing and the dispatch to
  the various functions that end up generating a
  table of the last _n_ issues in a gihub project
  """

  @doc "Entry point for CLI"
  def run(argv) do
    parse_args(argv)
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
        {user, project, @default_count}
    end
  end

  def process(query, options \\ [])

  def process(:help, _options) do
    IO.puts """
    usage: issues <user> <project> [ count | #{@default_count} ]
    """
  end

  def process({user, project, _count}, options) do
    api = options[:api] || @default_api
    api.fetch(user, project)
    |> decode_response
  end

  def decode_response({:ok, body}), do: body

  def decode_response({:error, error}) do
    message = error["message"]
    IO.puts "Error fetching from Github: #{message}"
  end
end
