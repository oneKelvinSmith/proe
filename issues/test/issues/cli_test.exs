defmodule Issues.CLITest do
  use ExUnit.Case
  import ExUnit.CaptureIO
  doctest Issues

  alias Issues.CLI, as: CLI

  describe "parse_args/1" do
    test ":help returned by option parameters -h and --help options" do
      assert CLI.parse_args(["-h", "anything"]) == :help
      assert CLI.parse_args(["--help", "anything"]) == :help
    end

    test "three values returned if three given" do
      assert CLI.parse_args(["user", "project", "99"]) == {"user", "project", 99}
    end

    test "count is defaulted if two values given" do
      assert CLI.parse_args(["user", "project"]) == {"user", "project", 4}
    end
  end

  describe "process/1" do
    test "outputs help text" do
      assert capture_io(fn ->
        CLI.process(:help)
      end) == """
      usage: issues <user> <project> [ count | 4 ]

      """
    end
  end

  describe "process/2" do
    defmodule APIStub do
      @behaviour Issues.GithubIssues

      def fetch(user, project) do
        send self, %{user: user, project: project}
        body = [
          %{"number" => "42", "created_at" => "0042-42-42", "title" => "Issue42"}
        ]
        {:ok, body}
      end
    end

    test "calls out the fetch api" do
      capture_io(fn ->
        CLI.process({"user", "project", 4}, api: APIStub)
      end)

      assert_received %{user: "user", project: "project"}
    end

    test "returns body on successful fetch" do
      assert capture_io(fn ->
        CLI.process({"user", "project", 4}, api: APIStub)
      end) == """
      number | created_at | title\s\s
      -------+------------+--------
      42     | 0042-42-42 | Issue42
      """
    end

    defmodule SystemStub do
      def halt(exit_code) do
        send self, %{exit_code: exit_code}
        exit(:normal)
      end
    end

    defmodule BrokenAPIStub do
      @behaviour Issues.GithubIssues

      def fetch(_user, _project) do
        {:error, %{"message" => "Madness has occurred"}}
      end
    end

    test "handles error case gracefully" do
      assert capture_io(fn ->
        catch_exit(
          CLI.process(
            {"irrelevant", "project", 42},
            api: BrokenAPIStub,
            system: SystemStub
          )
        )
      end) == "Error fetching from Github: Madness has occurred\n"
    end

    test "halts the system on error" do
      capture_io(fn ->
        catch_exit(
          CLI.process(
            {"irrelevant", "project", 42},
            api: BrokenAPIStub,
            system: SystemStub
          )
        )
      end)

      assert_received %{exit_code: 2}
    end

    defmodule ManyIssuesAPIStub do
      @behaviour Issues.GithubIssues

      def fetch(_user, _project) do
        body = [
          %{"number" => "1", "created_at" => "0001-01-01", "title" => "Issue1"},
          %{"number" => "2", "created_at" => "0002-02-02", "title" => "Issue2"},
          %{"number" => "3", "created_at" => "0003-03-03", "title" => "Issue3"},
          %{"number" => "4", "created_at" => "0004-04-04", "title" => "Issue4"},
          %{"number" => "5", "created_at" => "0005-05-05", "title" => "Issue5"},
        ]
        {:ok, body}
      end
    end

    test "returns the expected number of issues" do
      assert capture_io(fn ->
        CLI.process({"user", "project", 4}, api: ManyIssuesAPIStub)
      end) == """
      number | created_at | title\s
      -------+------------+-------
      1      | 0001-01-01 | Issue1
      2      | 0002-02-02 | Issue2
      3      | 0003-03-03 | Issue3
      4      | 0004-04-04 | Issue4
      """
    end
  end

  describe "sort_into_ascending_order/1" do
    test "sorts in ascending order correctly" do
      expected = ["c", "a", "b"]
      |> fake_issues
      |> CLI.sort_into_ascending_order
      |> values

      assert expected == ~w{a b c}
    end

    defp values(issues) do
      for issue <- issues, do: issue["created_at"]
    end

    defp fake_issues(values) do
      for value <- values, do: %{"created_at" => value, "other" => "data"}
    end
  end
end
