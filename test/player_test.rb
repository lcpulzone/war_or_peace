require 'minitest/autorun'
require 'minitest/pride'
require './lib/card'
require './lib/deck'
require './lib/player'

class PlayerTest < Minitest::Test

  def setup
    @card1 = Card.new(:diamond, 'Queen', 12)
    @card2 = Card.new(:spade, '3', 3)
    @card3 = Card.new(:heart, 'Ace', 14)
    @card4 = Card.new(:club, '5', 5)
    @deck = Deck.new(@cards)
    @player = Player.new('Clarisa', @deck)
    @deck.add_card(@card1)
    @deck.add_card(@card2)
    @deck.add_card(@card3)
  end

  def test_it_exists
    assert_instance_of Player, @player
  end

  def test_it_has_a_name_and_a_deck
    assert_equal "Clarisa", @player.name
    assert_equal @deck, @player.deck
  end

  def test_player_loses_when_deck_is_empty
    assert_equal false, @player.has_lost?

    @player.deck.remove_card

    assert_equal false, @player.has_lost?

    @player.deck.remove_card

    assert_equal false, @player.has_lost?

    @player.deck.remove_card

    assert_equal true, @player.has_lost?

    assert_equal @deck, @player.deck
  end

  def test_it_can_find_rank_of_card_in_deck
    assert_equal 12, @player.rank_of_card(0)
  end

  def test_it_can_find_high_ranking_cards
    assert_equal [@card1, @card3], @player.high_ranking_cards
  end

  def test_it_can_add_a_card_to_the_deck
    @player.add_card(@card4)
    assert_equal @deck, @player.deck
  end

  def test_it_can_remove_a_card_from_the_front
    assert_equal @card1, @player.remove_card
  end
end
