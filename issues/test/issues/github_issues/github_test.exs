defmodule Issues.GituhubIssues.GithubTest do
  use ExUnit.Case
  doctest Issues

  import Issues.GithubIssues.Github, only: [fetch: 2, issues_url: 2, handle_response: 1]

  @tag :httpoison
  describe "fetch/2" do
    setup do
      HTTPoison.start
      :ok
    end

    test "returns the cleaned up response from HTTPoison get" do
      assert fetch("oneKelvinSmith", "proe") == {:ok, "[]"}
    end
  end

  describe "issues_url/2" do
    test "returns the https github url for the given user and project" do
      expected_url = "https://api.github.com/repos/oneKelvinSmith/proe/issues"
      assert issues_url("oneKelvinSmith", "proe") == expected_url
    end
  end

  describe "handle_response/1" do
    test "returns the body of a successful response as on :ok tuple" do
      response = {:ok, %{status_code: 200, body: "[{\"key\":\"value\"}]"}}
      assert handle_response(response) == {:ok, [%{"key" => "value"}]}
    end

    test "returns the body of an unsuccessful response as on :error tuple" do
      response = {:anything, %{status_code: 999, body: "[{\"key\":\"value\"}]"}}
      assert handle_response(response) == {:error, [%{"key" => "value"}]}
    end
  end
end
