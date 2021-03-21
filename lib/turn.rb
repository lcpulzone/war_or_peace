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

  def war
    if war_card_comparison
      :war
    end
  end

  def mutually_assured_destruction
    if mad_card_comparison
      :mutually_assured_destruction
    end
  end

  def winner
    if mad_card_comparison
      return "No Winner"
    elsif war_card_comparison && p1_third_card_higher
      return @player1
    elsif war_card_comparison && p2_third_card_higher
      return@player2
    elsif basic_card_comparison_p1
      return @player1
    elsif basic_card_comparison_p2
      return @player2
    end
  end

  def pile_cards
    if mad_card_comparison
      mad_p1_remove_cards
      mad_p2_remove_cards
    elsif war_card_comparison
      spoils_of_war << player1.deck.cards[0..2]
      spoils_of_war << player2.deck.cards[0..2]
      spoils_of_war.flatten!
    elsif basic_card_comparison_p1
      spoils_of_war << player2.deck.cards[0]
    elsif basic_card_comparison_p2
      spoils_of_war << player1.deck.cards[0]
    end
  end

  def award_spoils(winner)
    winner.add_card(@spoils_of_war).flatten!
  end

  def basic_card_comparison_p1
    player1.rank_of_card(0) > player2.rank_of_card(0)
  end

  def basic_card_comparison_p2
    player1.rank_of_card(0) < player2.rank_of_card(0)
  end

  def war_card_comparison
    third_card_rank_not_equal && first_card_rank_comparison
  end


  def mad_card_comparison
    third_card_rank_is_equal && first_card_rank_comparison
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

  def p1_third_card_higher
    @player1.rank_of_card(2) > @player2.rank_of_card(2)
  end

  def p2_third_card_higher
    @player1.rank_of_card(2) < @player2.rank_of_card(2)
  end
  
  def first_card_rank_comparison
    player1.rank_of_card(0) == player2.rank_of_card(0)
  end

  def third_card_rank_not_equal
    player1.rank_of_card(2) != player2.rank_of_card(2)
  end

  def third_card_rank_is_equal
    player1.rank_of_card(2) == player2.rank_of_card(2)
  end
end
