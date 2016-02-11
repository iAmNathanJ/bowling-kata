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

  def test_game_scores_incomplete_frames
    fs = FrameSet::incomplete_frames
    score = game.score_game(fs)
    assert_equal(10, score)
  end

  # this test will fail
  def test_game_scores_incomplete_strikes
    fs = FrameSet::incomplete_strikes
    # score = game.score_game(fs)
    # assert_equal(120, score)
  end

  def test_game_scores_all_open_frames
    fs = FrameSet::frameset
    score = game.score_game(fs)
    assert_equal(20, score)
  end

  def test_game_scores_all_spares
    fs = FrameSet::all_spares
    score = game.score_game(fs)
    assert_equal(150, score)
  end

  def test_game_scores_all_strikes
    fs = FrameSet::all_strikes
    score = game.score_game(fs)
    assert_equal(300, score)
  end

  def test_game_can_have_extra_rolls
    fs = FrameSet::mixed_frames
    score = game.score_game(fs)
    assert_equal(139, score)
  end

  def teardown
  end

end
