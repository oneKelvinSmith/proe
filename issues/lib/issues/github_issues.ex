defmodule Issues.GithubIssues do
  @moduledoc """
  Specification for the GithubIssues api.
  """

  @typep user :: String.t
  @typep project :: String.t

  @doc """
  Fetches issues for a given `user`'s '`project`.
  """
  @callback fetch(user :: String.t, project :: String.t) :: {:ok, term} | {:error, term}
end
