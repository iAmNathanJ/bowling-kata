require "test/unit"
require_relative "../bowling_game"
require_relative "../frame"

class TestBowlingGame < Test::Unit::TestCase

  def setup
  end

  def test_game_exists
    game = BowlingGame.new
    assert(game != nil, "Game doesn't exist.")
  end

  def test_game_has_ten_frames
    game = BowlingGame.new
    assert(game.frames.length == 10, "Game doesn't have 10 frames.")
  end

  def test_frame_only_allows_ten_points
    frame = Frame.new
    frame.bowl
    assert(frame.score < 10, "Frame allows more than ten points")
  end

  def test_frame_only_allows_two_rolls
    frame = Frame.new
    frame.bowl
    frame.bowl
    assert(frame.bowl == Exception, "Frame allows more than two rolls")
  end

  def test_frame_spare_return_spare
  end

  def test_frame_strike_returns_strike
  end

  def teardown
  end

end
