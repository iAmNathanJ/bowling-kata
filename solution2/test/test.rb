require "test/unit"
require_relative "../bowling_game"

class TestBowlingGame < Test::Unit::TestCase

  attr_accessor :game

  def setup
    @game = BowlingGame.new
  end

  def test_game_exists
    assert(game)
  end

  def teardown
  end

end
