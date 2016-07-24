defmodule Issues.GithubIssues.Github do
  @behaviour Issues.GithubIssues

  def issues_url(user, project) do
    "https://github.com/#{user}/#{project}/issues"
  end

  def handle_response({:ok, %{status_code: 200, body: body}}) do
    {:ok, body}
  end

  def handle_response({_, %{status_code: _, body: body}}) do
    {:error, body}
  end
end
