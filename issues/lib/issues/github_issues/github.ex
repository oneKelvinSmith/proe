defmodule Issues.GithubIssues.Github do
  @moduledoc """
  Implimentation for the GithubIssues Github api.
  """

  @behaviour Issues.GithubIssues

  require Logger

  @user_agent [{"User-agent", "github@example.com"}]

  def fetch(user, project) do
    Logger.info "Fetching user #{user}'s project #{project}"
    issues_url(user, project)
    |> HTTPoison.get(@user_agent)
    |> handle_response
  end

  @github_url Application.get_env(:issues, :github_url)

  def issues_url(user, project) do
    "#{@github_url}/repos/#{user}/#{project}/issues"
  end

  def handle_response({:ok, %{status_code: 200, body: body}}) do
    Logger.info "Successful response"
    Logger.debug fn -> inspect(body) end
    {:ok, parse_json(body)}
  end

  def handle_response({_, %{status_code: status, body: body}}) do
    Logger.error "Error #{status} returned"
    {:error, parse_json(body)}
  end

  def parse_json(body) do
    Poison.Parser.parse!(body)
  end
end
