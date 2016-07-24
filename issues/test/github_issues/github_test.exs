defmodule GithubTest do
  use ExUnit.Case
  doctest Issues

  import Issues.GithubIssues.Github, only: [issues_url: 2, handle_response: 1]
  import ExUnit.CaptureIO

  describe "fetch/2" do
    test "returns the cleaned up response from HTTPoison get" do
    end
  end

  describe "issues_url/2" do
    test "returns the https github url for the given user and project" do
      expected_url = "https://github.com/oneKelvinSmith/proe/issues"
      assert issues_url("oneKelvinSmith", "proe") == expected_url
    end
  end

  describe "handle_response/1" do
    test "returns the body of a successful response as on :ok tuple" do
      response = {:ok, %{status_code: 200, body: "body"}}
      assert handle_response(response) == {:ok, "body"}
    end

    test "returns the body of an unsuccessful response as on :error tuple" do
      response = {:anything, %{status_code: 999, body: "body"}}
      assert handle_response(response) == {:error, "body"}
    end
  end
end
