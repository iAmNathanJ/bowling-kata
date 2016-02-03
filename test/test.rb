require "test/unit"
require_relative "../bowling_game"
require_relative "../frame"

class TestBowlingGame < Test::Unit::TestCase

  def setup
    @game = BowlingGame.new
  end

  def test_game_exists
    assert(@game != nil)
  end

  def test_game_has_ten_frames
    game = BowlingGame.new
    assert(game.frames.length == 10)
  end

  def frame_only_allows_ten_points
  end

  def frame_only_allows_two_rolls
  end

  def test_frame_spare_return_spare
  end

  def test_frame_strike_returns_strike
  end

end
