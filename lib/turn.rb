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
    if mutually_assured_destruction
      :mutually_assured_destruction
    elsif war
      :war
    elsif basic
      :basic
    end
  end

  def basic
    if basic_card_comparison_p1
      :basic
    elsif
      basic_card_comparison_p2
      :basic
    end
  end

  def basic_card_comparison_p1
    player1.rank_of_card(0) > player2.rank_of_card(0)
      spoils_of_war << player2.deck.cards[0]
  end

  def basic_card_comparison_p2
    player1.rank_of_card(0) < player2.rank_of_card(0)
    spoils_of_war << player1.deck.cards[0]
  end

  def war
    if war_card_comparison
    spoils_of_war << player1.deck.cards[0..2]
    spoils_of_war << player2.deck.cards[0..2]
    spoils_of_war.flatten!
    :war
    end
  end

  def war_card_comparison
    player1.rank_of_card(2) != player2.rank_of_card(2) && player1.rank_of_card(0) == player2.rank_of_card(0)
  end

  def mutually_assured_destruction
    if mad_card_comparison
      mad_p1_remove_cards
      mad_p2_remove_cards
    :mutually_assured_destruction
    end
  end

  def mad_card_comparison
    player1.rank_of_card(2) == player2.rank_of_card(2) && player1.rank_of_card(0) == player2.rank_of_card(0)
  end

  def mad_p1_remove_cards
    3.times do
      player1.remove_card
    end
  end

  def mad_p2_remove_cards
    3.times do
      player2.remove_card
    end
  end
end
