defmodule ScrabbleTest do
  use ExUnit.Case

  # @tag :pending
  test "empty word scores zero" do
    assert Scrabble.score("") == 0
  end

  test "whitespace scores zero" do
    assert Scrabble.score(" \t\n") == 0
  end

  test "scores very short word" do
    assert Scrabble.score("a") == 1
  end

  test "scores other very short word" do
    assert Scrabble.score("f") == 4
  end

  test "simple word scores the number of letters" do
    assert Scrabble.score("street") == 6
  end

  test "complicated word scores more" do
    assert Scrabble.score("quirky") == 22
  end

  test "scores are case insensitive" do
    assert Scrabble.score("OXYPHENBUTAZONE") == 41
  end

  test "convenient scoring" do
    assert Scrabble.score("alacrity") == 13
  end
end
