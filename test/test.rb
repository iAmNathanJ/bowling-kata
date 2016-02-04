require "test/unit"
require_relative "../bowling_game"
require_relative "../frame"

class TestBowlingGame < Test::Unit::TestCase

  attr_accessor :game, :frame_1, :frame_2, :frame_3

  def setup
    @game = BowlingGame.new
    @frame_1 = game.frames[0]
    @frame_2 = game.frames[1]
    @frame_3 = game.frames[2]
  end

  def test_frame_rolls_cannot_exceed_two
    frame_1.bowl(1)
    frame_1.bowl(1)
    assert_raise do
      frame_1.bowl
    end
  end

  def test_frame_pins_cannot_exceed_ten
    frame_1.bowl(11)
    assert(frame_1.pins == 10, "Frame allows more than ten pins")
    frame_2.bowl(5)
    frame_2.bowl(6)
    assert(frame_2.pins == 10, "Frame allows more than ten pins")
  end

  def test_frame_tracks_total_pins
    frame_1.bowl(1)
    frame_1.bowl(1)
    assert(frame_1.pins == 2)
  end

  def test_frame_spare_return_spare
    frame_1.bowl(9)
    frame_1.bowl(1)
    assert(game.score_frame(frame_1) == [9, "/"])
  end

  def test_frame_strike_returns_strike
    frame_1.bowl(10)
    assert(game.score_frame(frame_1) == "x")
  end

  def test_game_exists
    assert(game != nil, "Game doesn't exist.")
  end

  def test_game_has_ten_frames
    assert(game.frames.length == 10, "Game doesn't have 10 frames.")
  end

  def test_game_all_rolls_is_flat_array
    frame_1.bowl(1)
    frame_1.bowl(1)
    assert(game.all_rolls == [1, 1])
    frame_2.bowl(10)
    assert(game.all_rolls == [1, 1, "x"])
  end

  def test_game_score_is_a_Fixnum
    frame_1.bowl(1)
    frame_1.bowl(1)
    assert(game.score_game.class == Fixnum)
  end

  def test_strike_adds_next_two_rolls
    # --------------------
    frame_1.bowl(10)  # 20
    # --------------------
    frame_2.bowl(3)   # 11
    frame_2.bowl(7)
    # --------------------
    frame_3.bowl(1)   # 2
    frame_3.bowl(1)
    # --------------------
    p game.all_rolls
    p game.to_num(game.all_rolls)
    p game.score_game
    assert(game.score_game == 33)
  end

  def teardown
  end

end
