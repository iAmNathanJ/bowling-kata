require "test/unit"
require_relative "../game"
require_relative "mock"

class TestGameDriver < Test::Unit::TestCase

  attr_accessor :game

  def setup
    @game = Game.new
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
    score = game.get_score("suzy")
    assert_equal(0, score)
  end

  def test_player_score_can_be_updated
    game.add_player("Suzy")
    game.update_score("suzy", 100)
    score = game.get_score("suzy")
    assert_equal(100, score)
  end

  def teardown
  end

end
