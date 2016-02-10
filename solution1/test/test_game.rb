require "test/unit"
require_relative "../bowling_game"

class TestBowlingGame < Test::Unit::TestCase

  attr_accessor :game

  def setup
    @game = BowlingGame.new
  end

  def test_game_is_a_thing
    assert(game != nil, "Game doesn't exist.")
  end

  def test_game_has_frames
    assert(game.frames != nil)
  end

  def test_game_tracks_current_frame
    assert_equal(0, game.current_frame_num)
  end

  def test_game_can_bowl
    assert_respond_to(game, :bowl)
  end

  def test_game_can_score
    assert_respond_to(game, :score)
  end

  def test_game_scores_open_frames
    game.bowl(1)
    game.bowl(1)
    game.bowl(1)
    game.bowl(1)
    assert_equal(4, game.score)
  end

  def test_game_scores_spare
    game.bowl(5)
    game.bowl(5)
    game.bowl(5)
    assert_equal(20, game.score)
  end

  def test_game_scores_strikes
    game.bowl(10)
    game.bowl(10)
    game.bowl(10)
    assert_equal(60, game.score)
  end

  def test_game_scores_mixed_frames
    game.bowl(10)
    game.bowl(1)
    game.bowl(1)
    game.bowl(5)
    game.bowl(5)
    game.bowl(1)
    assert_equal(26, game.score)
  end

  def test_game_scores_all_strikes
    12.times do
      game.bowl(10)
    end
    assert_equal(300, game.score)
  end

  def teardown
  end

end
