defmodule CliTest do
  use ExUnit.Case
  doctest Issues

  import Issues.CLI, only: [run: 1, parse_args: 1, process: 1, process: 2]
  import ExUnit.CaptureIO

  describe "parse_args/1" do
    test ":help returned by option parameters -h and --help options" do
      assert parse_args(["-h", "anything"]) == :help
      assert parse_args(["--help", "anything"]) == :help
    end

    test "three values returned if three given" do
      assert parse_args(["user", "project", "99"]) == {"user", "project", 99}
    end

    test "count is defaulted if two values given" do
      assert parse_args(["user", "project"]) == {"user", "project", 4}
    end
  end

  describe "run/1" do
    test "run calls parse_args" do
      args = ["user", "project"]
      assert run(args) == parse_args(args)
    end
  end

  describe "process/1" do
    test "outputs help text" do
      assert capture_io(fn ->
        process(:help)
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
        {:ok, %{"body" => "Success"}}
      end
    end

    test "calls out the fetch api" do
      process({"oneKelvinSmith", "proe", 4}, api: APIStub)

      assert_received %{user: "oneKelvinSmith", project: "proe"}
    end

    test "returns body on successful fetch" do
      assert process(
        {"oneKelvinSmith", "proe", 4}, api: APIStub
      ) == %{"body" => "Success"}
    end

    defmodule SystemStub do
      def halt(exit_code) do
        send self, %{exit_code: exit_code}
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
        process(
          {"irrelevant", "project", 42},
          api: BrokenAPIStub,
          system: SystemStub
        )
      end) == "Error fetching from Github: Madness has occurred\n"
    end

    test "halts the system on error" do
      capture_io(fn ->
        process(
          {"irrelevant", "project", 42},
          api: BrokenAPIStub,
          system: SystemStub
        )
      end)

      assert_received %{exit_code: 2}
    end
  end
end
