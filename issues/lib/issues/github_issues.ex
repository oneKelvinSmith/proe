defmodule Issues.GithubIssues do
  @moduledoc """
  Specification for the GithubIssues api.
  """

  @typep user :: String.t
  @typep project :: String.t

  @doc """
  Fetches issues for a given `user`'s '`project`.
  """
  @callback fetch(user :: user, project :: project) :: {:ok, term} | {:error, term}
end
