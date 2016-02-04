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

  def test_frame_allows_ten_pin_max
    frame = Frame.new
    frame.bowl(11)
    assert(frame.pins == 10, "Frame allows more than ten points")
  end

  def test_frame_allows_two_roll_max
    frame = Frame.new
    frame.bowl(1)
    frame.bowl(1)
    assert_raise do
      frame.bowl
    end
  end

  def test_frame_tracks_total_pins
    frame = Frame.new
    frame.bowl(1)
    frame.bowl(1)
    assert(frame.pins == 2)
  end

  def test_frame_spare_return_spare
    game = BowlingGame.new
    frame = game.frames[0]
    frame.bowl(9)
    frame.bowl(1)
    assert(game.score_frame(frame) == "/")
  end

  def test_frame_strike_returns_strike
    game = BowlingGame.new
    frame = game.frames[0]
    frame.bowl(10)
    assert(game.score_frame(frame) == "x")
  end

  def teardown
  end

end
