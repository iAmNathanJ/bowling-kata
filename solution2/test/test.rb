require "test/unit"
require_relative "../bowling_game"
require_relative "mock"

class TestBowlingGame < Test::Unit::TestCase

  attr_accessor :game, :frameset

  def setup
    @game = BowlingGame.new
    @frameset = FrameSet.frameset
  end

  def test_game_exists
    assert(game)
  end

  def test_game_has_ten_frames
    # frame count 10
    assert(game.frames.length == 10)
  end

  def test_game_can_score_complete_frameset
    score = game.score_game(frameset)
    assert(score == 30)
  end

  def test_game_scores_open_frames
    # scores open frame
  end

  def test_game_scores_spares
    # throws if subs aren't available
    # scores spare if subs are available
  end

  def test_game_scores_strikes
    # throws if subs aren't available
    # scores spare if subs are available
  end

  def test_game_can_have_extra_rolls
  end

  def teardown
  end

end
