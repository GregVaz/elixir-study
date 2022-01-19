defmodule CardsTest do
  use ExUnit.Case
  doctest Cards

  test "Return a complete deck" do
    assert length(Cards.create_deck()) == 20
  end

  test "shuffling a deck randomized it" do
    deck = Cards.create_deck()
    refute deck == Cards.shuffle(deck)
  end
end
