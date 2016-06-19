defmodule WordsTest do
  use ExUnit.Case

  import ExUnit.CaptureIO

  test "anagram?/2 returns true when the given words are anagrams of each other" do
    assert Words.anagram?("dog", "god") == true
  end

  test "anagram?/2 returns false when the given words are not anagrams of each other" do
    assert Words.anagram?("madness", "insanity") == false
  end

  test "anagram?/2 returns false when words of same lenght are not anagrams of each other" do
    assert Words.anagram?("inextricably", "unmanageable") == false
  end

  test "center/1 centers the words in a column as wide as the longest word" do
    assert capture_io(fn ->
      Words.center(["cat", "zebra", "elephant"])
    end) == "  cat\n zebra\nelephant\n"
  end

  test "center/1 does returns and empty strin when the list is empty" do
    assert capture_io(fn ->
      Words.center([])
    end) == ""
  end

  test "capitalize_sentences/1 capitalizes sentencs..." do
    assert Words.capitalize_sentences("oh. a DOG. woof.") == "Oh. A dog. Woof."
  end

  test "capitalizes_sentences/1 does not modify non characters" do
    assert Words.capitalize_sentences("oh. #@!$%. maDNeSS.") == "Oh. #@!$%. Madness."
  end

  test "capitalize_sentences/1 returns an empty string when one is given" do
    assert Words.capitalize_sentences("") == ""
  end
end
