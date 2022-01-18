defmodule Cards do
  @moduledoc """
  Provides methods for creating and handling a deck of cards
  """

  @doc """
    Return a list of cards
  """
  def create_deck do
    values = ["Ace", "Two", "Three", "Four", "Five"]
    suits = ["Spades", "Clubs", "Hearts", "Diamonds"]

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
  """
  def shuffle(deck) do
    Enum.shuffle(deck)
  end

  @doc """
    Determines whether a deck contains a given card

  ## Examples

      iex> deck = Cards.create_deck()
      iex> Cards.contains?(deck, "Ace of Spades")
      true

  """
  def contains?(deck, hand) do
    Enum.member?(deck, hand)
  end

  @doc """
  Return a list of requested cards

  ## Examples

      iex> deck = Cards.create_deck()
      iex> Cards.deal(deck, 2)
      ["Ace of Spades", "Two of Spades"]

  """
  def deal(deck, hand_size) do
    {hand, _} = Enum.split(deck, hand_size)
    hand
  end

  @doc """
    Save a list of cards into a file system
  """
  def save(deck, filename) do
    binary = :erlang.term_to_binary(deck)
    File.write(filename, binary)
  end

  @doc """
    Load a list of cards from a file system
  """
  def load(filename) do
    case File.read(filename) do
      {:ok, binary} -> :erlang.binary_to_term(binary)
      {:error, _reason} -> "That file does not exists"
    end
  end

  @doc """
    Create a hand for the user using the create_deck, shuffle and deal methods
  """
  def create_hand(hand_size) do
    create_deck()
    |> Cards.shuffle()
    |> Cards.deal(hand_size)
  end
end
