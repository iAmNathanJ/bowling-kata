require "test/unit"
require_relative "../bowling_game"

class TestBowlingGame < Test::Unit::TestCase

  attr_accessor :game

  def setup
    @game = BowlingGame.new
  end

  def test_game_exists
    assert(game != nil, "Game doesn't exist.")
  end

  def test_game_has_ten_frames
    assert(game.frames.length == 10, "Game doesn't have 10 frames.")
  end

  def test_game_all_rolls_is_flat_array
    game.bowl(1)
    game.bowl(1)
    assert(game.all_rolls == [1, 1])
    game.bowl(10)
    assert(game.all_rolls == [1, 1, "x"])
  end

  def test_game_score_is_a_Fixnum
    game.bowl(1)
    game.bowl(1)
    assert(game.score.class == Fixnum)
  end

  def test_strike_adds_next_two_rolls
    # --------------------
    game.bowl(10)  # 12
    # --------------------
    game.bowl(1)   # 2
    game.bowl(1)
    # --------------------
    assert(game.score == 14)
  end

  def test_spare_adds_next_roll
    # --------------------
    game.bowl(9)  # 11
    game.bowl(1)
    # --------------------
    game.bowl(1)   # 2
    game.bowl(1)
    # --------------------
    assert(game.score == 13)
  end

  def test_turkey_is_scored_accurately
    # --------------------
    game.bowl(10)  # 30
    # --------------------
    game.bowl(10)  # 20
    # --------------------
    game.bowl(10)  # 10
    # --------------------
    assert(game.score == 60)
  end

  def teardown
  end

end
