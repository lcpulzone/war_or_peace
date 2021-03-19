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
end
