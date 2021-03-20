require 'minitest/autorun'
require 'minitest/pride'
require './lib/card'
require './lib/deck'
require './lib/player'
require './lib/turn'

class TurnTest < Minitest::Test

  def setup
  @card1 = Card.new(:heart, 'Jack', 11)
  @card2 = Card.new(:heart, '10', 10)
  @card5 = Card.new(:heart, '8', 8)
  @card8 = Card.new(:diamond, '2', 2)
  @deck1 = Deck.new([@card1, @card2, @card5, @card8])
  @player1 = Player.new("Megan", @deck1)
  @deck1.add_card(@card1)
  @deck1.add_card(@card2)
  @deck1.add_card(@card5)
  @deck1.add_card(@card8)

  @card3 = Card.new(:heart, '9', 9)
  @card4 = Card.new(:diamond, 'Jack', 11)
  @card6 = Card.new(:diamond, 'Queen', 12)
  @card7 = Card.new(:heart, '3', 3)
  @deck2 = Deck.new([@card3, @card4, @card6, @card7])
  @player2 = Player.new("Aurora", @deck2)
  @deck2.add_card(@card3)
  @deck2.add_card(@card4)
  @deck2.add_card(@card6)
  @deck2.add_card(@card7)

  @turn = Turn.new(@player1, @player2)
  end

  def test_it_exists
    assert_instance_of Turn, @turn
  end

  def test_it_has_readable_attributes
    assert_equal @player1, @turn.player1
    assert_equal @player2, @turn.player2
    assert_equal [], @turn.spoils_of_war
  end

  def test_it_can_have_a_basic_turn
    assert_equal :basic, @turn. type
    assert_equal [@card3], @turn.spoils_of_war
    assert_equal @player1, @turn.winner
  end

  def test_it_can_have_a_war_turn
    @deck1 = Deck.new([@card1, @card2, @card5, @card8])
    @player1 = Player.new("Megan", @deck1)
    @deck1.add_card(@card1)
    @deck1.add_card(@card2)
    @deck1.add_card(@card5)
    @deck1.add_card(@card8)

    @deck2 = Deck.new([@card4, @card3, @card6, @card7])
    @player2 = Player.new("Aurora", @deck2)
    @deck2.add_card(@card4)
    @deck2.add_card(@card3)
    @deck2.add_card(@card6)
    @deck2.add_card(@card7)

    @turn = Turn.new(@player1, @player2)

    assert_equal :war, @turn.type
    assert_equal [@card1, @card2, @card5, @card4, @card3, @card6], @turn.spoils_of_war
    assert_equal @player2, @turn.winner
  end

  def test_it_can_have_mutually_assured_destruction
    @deck1 = Deck.new([@card1, @card2, @card5, @card8])
    @player1 = Player.new("Megan", @deck1)
    @deck1.add_card(@card1)
    @deck1.add_card(@card2)
    @deck1.add_card(@card5)
    @deck1.add_card(@card8)

    @card6 = Card.new(:diamond, '8', 8)
    @deck2 = Deck.new([@card4, @card3, @card6, @card7])
    @player2 = Player.new("Aurora", @deck2)
    @deck2.add_card(@card4)
    @deck2.add_card(@card3)
    @deck2.add_card(@card6)
    @deck2.add_card(@card7)

    @turn = Turn.new(@player1, @player2)
    assert_equal "No Winner", @turn.winner
    assert_equal :mutually_assured_destruction, @turn.type
    refute_equal [@card1, @card2, @card5], @turn.player1
    refute_equal [@card4, @card3, @card6], @turn.player2
  end

end
