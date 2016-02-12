require "test/unit"
require_relative "../game"
require_relative "mock"

class TestGameDriver < Test::Unit::TestCase

  attr_accessor :driver

  def setup
    @game = GameDriver.new(MockGame)
  end

  def test_game_is_a_thing
    assert_not_nil(game)
  end

  def test_game_has_players
    assert_not_nil(game.players)
    assert_equal(Hash, game.players.class)
  end

  def test_players_can_be_added
    game.add_player("Suzy")
    assert_equal("Suzy", game.players["suzy"][:name])
  end

  def test_players_cannot_have_duplicate_names
    game.add_player("Suzy")
    assert_raise do
      game.add_player("Suzy")
    end
  end

  def test_players_initial_score
    game.add_player("Suzy")
    score = game.players["suzy"][:score]
    assert_equal(0, score)
  end

  def teardown
  end

end
