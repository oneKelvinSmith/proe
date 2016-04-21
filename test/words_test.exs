defmodule WordsTest do
  use ExUnit.Case

  test "anagram?/2 returns true when the given words are anagrams of each other" do
    assert Words.anagram?("dog", "god") == true
  end

  test "anagram?/2 returns false when the given words are not anagrams of each other" do
    assert Words.anagram?("madness", "insanity") == false
  end

  test "anagram?/2 returns false when words of same lenght are not anagrams of each other" do
    assert Words.anagram?("inextricably", "unmanageable") == false
  end
end
