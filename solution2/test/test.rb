require "test/unit"
require_relative "../bowling_game"
require_relative "mock"

class TestBowlingGame < Test::Unit::TestCase

  attr_accessor :game

  def setup
    @game = BowlingGame.new
  end

  def test_game_exists
    assert(game)
  end

  def test_game_scores_all_open_frames
    fs = FrameSet::frameset
    score = game.score_game(fs)
    assert(score == 20)
  end

  def test_game_scores_all_spares
    fs = FrameSet::all_spares
    score = game.score_game(fs)
    assert(score == 150)
  end

  def test_game_scores_all_strikes
    fs = FrameSet::all_strikes
    score = game.score_game(fs)
    assert(score == 300)
  end

  def test_game_can_have_extra_rolls
    fs = FrameSet::mixed_frames
    score = game.score_game(fs)
    assert(score == 139)
  end

  def teardown
  end

end
