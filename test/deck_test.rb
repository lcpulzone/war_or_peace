require 'minitest/autorun'
require 'minitest/pride'
require './lib/deck'
require './lib/card'

class DeckTest < Minitest::Test

  def setup
    @card1 = Card.new(:diamond, 'Queen', 12)
    @card2 = Card.new(:spade, '3', 3)
    @card3 = Card.new(:heart, 'Ace', 14)
    @deck = Deck.new(@cards)
  end

  def test_it_exists
    assert_instance_of Deck, @deck
  end

  def test_it_has_no_cards
    assert_equal [], @deck.cards
  end

  def test_it_can_hold_cards
    @deck.add_cards(@card1)
    @deck.add_cards(@card2)
    @deck.add_cards(@card3)

    assert_equal [@card1, @card2, @card3], @deck.cards
  end

  def test_it_can_call_card_rank
    @deck.add_cards(@card1)
    @deck.add_cards(@card2)
    @deck.add_cards(@card3)

    assert_equal 12, @deck.rank_of_card_at(0)
    assert_equal 14, @deck.rank_of_card_at(2)
  end

  def test_it_can_find_high_ranking_cards
    @deck.add_cards(@card1)
    @deck.add_cards(@card2)
    @deck.add_cards(@card3)

    assert_equal [@card1, @card3], @deck.high_ranking_cards
  end

  def test_it_can_give_percentage_of_high_ranking_cards
    @deck.add_cards(@card1)
    @deck.add_cards(@card2)
    @deck.add_cards(@card3)

    assert_equal 66.67, @deck.percent_high_ranking
  end
end
#  deck.cards
# #=> [#<Card:0x007fbfd19f4fa0...>, #<Card:0x007fbfd18555a0...>]
#  deck.high_ranking_cards
# #=> [#<Card:0x007fbfd18555a0...>]
#  deck.percent_high_ranking
# #=> 50.0
#  card4 = Card.new(:club, '5', 5)
# #=> #<Card:0x007fbfd2963978 @rank=5, @suit=:club, @value="5">
#  deck.add_card(card4)
#  deck.cards
# #=> [#<Card:0x007fbfd19f4fa0...>, #<Card:0x007fbfd18555a0...>, #<Card:0x007fbfd2963978...>]
#  deck.high_ranking_cards
# #=> [#<Card:0x007fbfd18555a0...>]
#  deck.percent_high_ranking
# #=> 33.33
