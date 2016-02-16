require "test/unit"
require "../bowling_game"

class TestBowlingGame < Test::Unit::TestCase

  attr_reader :game, :game_2

  def setup
    @game = BowlingGame.new
    @game_2 = BowlingGame.new
  end

  def test_game_is_a_thing
    assert(game != nil, "Game doesn't exist.")
  end

  def test_game_has_rolls
    assert(game.rolls != nil)
    assert(game.rolls.class == Array)
  end

  def test_game_has_methods
    assert_respond_to(game, :bowl)
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

  def test_game_scores_strike
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

  def test_game_scores_all_spares
    22.times do
      game.bowl(5)
    end
    assert_equal(150, game.score)
  end

  def test_game_scores_all_strikes
    12.times do
      game.bowl(10)
    end
    assert_equal(300, game.score)
  end

  def test_game_scores_50_strikes
    50.times do
      game.bowl(10)
    end
    assert_equal(300, game.score)
  end

  def test_game_scoring_doesnt_change_data
    12.times do
      game.bowl(10)
    end
    assert_equal(300, game.score)
    assert_equal(300, game.score)
  end

  def test_game_gets_frames
    game.bowl(1)
    game.bowl(1)
    game.bowl(1)
    assert_equal([[1, 1], [1]], game.frames)

    game.bowl(1)
    game.bowl(10)
    game.bowl(3)
    assert_equal([[1, 1], [1, 1], [10], [3]], game.frames)

    12.times do
      game_2.bowl(10)
    end
    frames = ([] << [10]) * 10
    assert_equal(frames, game_2.frames)
  end

  def test_game_gets_extra_rolls
    12.times do
      game.bowl(10)
    end
    frames = ([10, 10])
    assert_equal(frames, game.extra_rolls)
  end

  def test_game_gets_targeted_frame
    game.bowl(1)
    game.bowl(2)
    game.bowl(3)
    game.bowl(4)
    frame = game.frames[1]
    assert_equal([3, 4], frame)

    game.bowl(10)
    game.bowl(10)
    frame = game.frames[3]
    assert_equal([10], frame)
  end

  def test_game_gets_current_frame
    game.bowl(10)
    assert_equal([10], game.current_frame)

    game.bowl(3)
    game.bowl(3)
    assert_equal([3, 3], game.current_frame)

    game.bowl(3)
    game.bowl(3)
    game.bowl(3)
    assert_equal([3], game.current_frame)
  end

  def test_game_tracks_completion
    10.times do
      game.bowl(10)
    end
    assert(!game.complete?)

    game.bowl(5)
    assert(!game.complete?)

    game.bowl(5)
    assert(game.complete?)

    9.times do
      game_2.bowl(10)
    end
    assert(!game_2.complete?)

    game_2.bowl(5)
    game_2.bowl(5)
    assert(!game_2.complete?)

    game_2.bowl(5)
    assert(game_2.complete?)

    game_3 = BowlingGame.new
    20.times do
      game_3.bowl(1)
    end
    assert(game_3.complete?)
  end

  def teardown
  end

end
