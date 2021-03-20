class Turn
  attr_reader  :player1,
                    :player2,
                    :spoils_of_war

  def initialize(player1, player2)
    @player1 = player1
    @player2 = player2
    @spoils_of_war = []
  end

  def type
    if basic
      :basic
    elsif war
      :war
    end
  end

  def basic
    if player1.rank_of_card(0) > player2.rank_of_card(0)
      spoils_of_war << player2.deck.cards[0]
      :basic
    elsif
      player1.rank_of_card(0) < player2.rank_of_card(0)
      spoils_of_war << player1.deck.cards[0]
      :basic
    end
  end

  def war
    player1.rank_of_card(0) == player2.rank_of_card(0)
    spoils_of_war << player1.deck.cards[0..2]
    spoils_of_war << player2.deck.cards[0..2]
    spoils_of_war.flatten!
    :war
  end
end
