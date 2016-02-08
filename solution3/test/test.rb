require "test/unit"
require_relative "mock"
require_relative "../bowling_game"

class TestBowling < Test::Unit::TestCase

  attr_accessor :game

  def setup
    @game = BowlingGame.new
  end

  def test_game_scores_all_strikes
    fs = FrameSet::all_strikes
    score = game.score_game(fs)
    p score
    assert(score == 300)
  end

  def test_game_scores_all_spares
    fs = FrameSet::all_spares
    score = game.score_game(fs)
    p score
    assert(score == 150)
  end

  def test_game_scores_all_open
    fs = FrameSet::all_open
    score = game.score_game(fs)
    p score
    assert(score == 20)
  end

  def test_game_scores_mixed_frames
    fs = FrameSet::mixed_frames
    score = game.score_game(fs)
    p score
    assert(score == 139)
  end

end
