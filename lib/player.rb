class Player
  attr_reader  :name,
                    :deck

  def initialize(name, deck)
    @name = name
    @deck = deck
  end

  def has_lost?
    deck.cards.empty?
  end

  def rank_of_card(index)
    deck.rank_of_card_at(index)
  end

  def high_ranking_cards
    deck.high_ranking_cards
  end

  def add_card(card)
    deck.add_card(card)
  end

  def remove_card
    deck.remove_card
  end
end
