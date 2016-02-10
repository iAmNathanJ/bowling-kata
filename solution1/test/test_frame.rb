require "test/unit"
require_relative "../frame"

class TestFrame < Test::Unit::TestCase

  attr_accessor :frame

  def setup
    @frame = Frame.new
  end

  def test_frame_rolls_is_array
    assert(frame.rolls.class == Array)
  end

  def test_frame_can_be_spare
    frame.add(5)
    assert(frame.spare? == false)
    frame.add(5)
    assert(frame.spare? == true)
    frame.modify(5)
    assert(frame.spare? == true)
  end

  def test_frame_can_be_strike
    assert(frame.strike? == false)
    frame.add(10)
    assert(frame.strike? == true)
    frame.modify(5)
    assert(frame.strike? == true)
  end

  def test_frame_tracks_total
    assert_equal(0, frame.total)
    frame.add(1)
    assert_equal(1, frame.total)
    frame.add(5)
    assert_equal(6, frame.total)
    frame.modify(1)
    assert_equal(7, frame.total)
  end

  def test_frame_can_be_done
    assert(frame.done? == false)
    frame.add(1)
    assert(frame.done? == false)
    frame.add(1)
    assert(frame.done? == true)
    frame_2 = Frame.new
    frame_2.add(10)
    assert(frame.done? == true)
  end

  def teardown
  end

end
