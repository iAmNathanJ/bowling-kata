require "test/unit"
require_relative "../frame"

class TestBowlingGame < Test::Unit::TestCase

  attr_accessor :frame, :frame_2

  def setup
    @frame = Frame.new
    @frame_2 = Frame.new
  end

  def test_frame_rolls_cannot_exceed_two
    frame.bowl(1)
    frame.bowl(1)
    assert_raise do
      frame.bowl
    end
  end

  def test_frame_pins_cannot_exceed_ten
    frame.bowl(11)
    assert(frame.pins == 10, "Frame allows more than ten pins")
    frame_2.bowl(5)
    frame_2.bowl(6)
    assert(frame_2.pins == 10, "Frame allows more than ten pins")
  end

  def test_frame_tracks_total_pins
    frame.bowl(1)
    frame.bowl(1)
    assert(frame.pins == 2)
  end

  def test_frame_rolls_is_array
    assert(frame.rolls.class == Array)
  end

  def test_frame_rolls_returns_spare
    frame.bowl(9)
    frame.bowl(1)
    assert(frame.rolls == [9, "/"])
  end

  def test_frame_rolls_returns_strike
    frame.bowl(10)
    assert(frame.rolls == ["x"])
  end

  def teardown
  end

end
