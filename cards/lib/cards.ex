defmodule Cards do
  @moduledoc """
  Documentation for `Cards`.
  """

  @doc """
  Return a list of cards

  ## Examples

      iex> Cards.create_deck()
      [card1, card2]

  """
  def create_deck do
    values = ["Ace", "Two", "Three", "Four", "Five"]
    suits = ["Spades", "Clubs", "Hearts", "Diaments"]

    # cards =
    #   for value <- values do
    #     for suit <- suits do
    #       "#{value} of #{suit}"
    #     end
    #   end

    # List.flatten(cards)

    for suit <- suits, value <- values do
      "#{value} of #{suit}"
    end
  end

  @doc """
  Return a suffle list of the deck

  ## Examples

      iex> Cards.shuffle()
      [card2, card1]

  """
  def shuffle(deck) do
    Enum.shuffle(deck)
  end

  @doc """
  Return a true or false if the card is into the deck

  ## Examples

      iex> Cards.contains?(["Ace", "Two"], "Ace")
      true

  """
  def contains?(deck, hand) do
    Enum.member?(deck, hand)
  end
end
