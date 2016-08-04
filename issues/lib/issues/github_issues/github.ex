defmodule Issues.GithubIssues.Github do
  @moduledoc """
  Implimentation for the GithubIssues Github api.
  """

  @behaviour Issues.GithubIssues

  @user_agent [{"User-agent", "github@example.com"}]

  def fetch(user, project) do
    issues_url(user, project)
    |> HTTPoison.get(@user_agent)
    |> handle_response
  end

  def issues_url(user, project) do
    "https://api.github.com/repos/#{user}/#{project}/issues"
  end

  def handle_response({:ok, %{status_code: 200, body: body}}) do
    {:ok, parse_json(body)}
  end

  def handle_response({_, %{status_code: _, body: body}}) do
    {:error, parse_json(body)}
  end

  def parse_json(body) do
    Poison.Parser.parse!(body)
  end
end
