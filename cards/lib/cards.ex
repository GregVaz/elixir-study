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

  @doc """
  Return a list of requested cards

  ## Examples

      iex> Cards.deal(["Ace", "Two"], 2)
      ["Ace", "Two"]

  """
  def deal(deck, hand_size) do
    {hand, _} = Enum.split(deck, hand_size)
    hand
  end

  @doc """
  Save a list of cards into a file system

  ## Examples

      iex> Cards.save(["Ace", "Two"], "my_deck")
      :ok

  """
  def save(deck, filename) do
    binary = :erlang.term_to_binary(deck)
    File.write(filename, binary)
  end

  @doc """
  Load a list of cards from a file system

  ## Examples

      iex> Cards.load("my_deck")
      ["Ace", "Two"]
  """
  def load(filename) do
    case File.read(filename) do
      {:ok, binary} -> :erlang.binary_to_term(binary)
      {:error, _reason} -> "That file does not exists"
    end
  end
end
