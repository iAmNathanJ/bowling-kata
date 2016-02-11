require "test/unit"
require_relative "../bowling_game"

class TestBowlingGame < Test::Unit::TestCase

  attr_accessor :game

  def setup
    @game = BowlingGame.new
  end

  def test_game_is_a_thing
    assert(game != nil, "Game doesn't exist.")
  end

  def test_game_has_rolls
    assert(game.rolls != nil)
    assert(game.rolls.class == Array)
  end

  def test_game_has_methods
    assert_respond_to(game, :bowl)
    assert_respond_to(game, :score)
  end

  def test_game_scores_open_frames
    game.bowl(1)
    game.bowl(1)
    game.bowl(1)
    game.bowl(1)
    assert_equal(4, game.score(game.rolls))
  end

  def test_game_scores_spare
    game.bowl(5)
    game.bowl(5)
    game.bowl(5)
    assert_equal(20, game.score(game.rolls))
  end

  def test_game_scores_strike
    game.bowl(10)
    game.bowl(10)
    game.bowl(10)
    assert_equal(60, game.score(game.rolls))
  end

  def test_game_scores_mixed_frames
    game.bowl(10)
    game.bowl(1)
    game.bowl(1)
    game.bowl(5)
    game.bowl(5)
    game.bowl(1)
    assert_equal(26, game.score(game.rolls))
  end

  def test_game_scores_all_spares
    22.times do
      game.bowl(5)
    end
    assert_equal(150, game.score(game.rolls))
  end

  def test_game_scores_all_strikes
    12.times do
      game.bowl(10)
    end
    assert_equal(300, game.score(game.rolls))
  end

  def test_game_scores_50_strikes
    50.times do
      game.bowl(10)
    end
    assert_equal(300, game.score(game.rolls))
  end

  def test_game_scoring_doesnt_change_data
    12.times do
      game.bowl(10)
    end
    assert_equal(300, game.score(game.rolls))
    assert_equal(300, game.score(game.rolls))
  end

  def teardown
  end

end
