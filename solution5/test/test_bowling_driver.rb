require "test/unit"
require_relative "../bowling_driver"
require_relative "mock"

class TestBowlingDriver < Test::Unit::TestCase

  attr_accessor :driver

  def setup
    @mock_io = MockIO.new
    @driver = BowlingGameDriver.new(@mock_io)
  end

  def test_driver_has_players
    players = driver.status[:players]
    assert_not_nil(players)
    assert_equal(Array, players.class)
  end

  def test_players_can_be_added
    driver.add_player("Suzy") do |player|
      assert_equal("Suzy", player[:name])
      assert_equal(BowlingGame, player[:game].class)
      @mock_io.write "#{player[:name]} Added!"
      assert_equal("Suzy Added!", @mock_io.output)
    end
  end

  def test_adds_players_forever
    driver.add_players do |players|
      assert_equal(3, players.length)
      assert_equal("Suzy", players[0][:name])
      assert_equal("Nate", players[1][:name])
      assert_equal("Karl", players[2][:name])
    end

    @mock_io.reset

    driver.add_players do |players|
      assert_equal(6, players.length)
      assert_equal("Suzy", players[3][:name])
      assert_equal("Nate", players[4][:name])
      assert_equal("Karl", players[5][:name])
    end

    @mock_io.reset

    driver.add_players do |players|
      assert_equal(9, players.length)
      assert_equal("Suzy", players[6][:name])
      assert_equal("Nate", players[7][:name])
      assert_equal("Karl", players[8][:name])
    end
  end

  def test_plays_frame
    driver.add_players { |players| }
    driver.play_frame do |game_status|
      player_1_rolls = game_status[:players][0][:game].rolls
      player_2_rolls = game_status[:players][1][:game].rolls
      player_3_rolls = game_status[:players][2][:game].rolls
      assert_equal([10], player_1_rolls)
      assert_equal([5, 5], player_2_rolls)
      assert_equal([1, 0], player_3_rolls)
    end

    @mock_io.reset
  end

  def test_game_done
    # driver.add_players { |players| }
    # 10.times do
    #   driver.play_frame { |game_status| }
    # end
  end

  def test_plays_all_frames
    driver.play
  end

  def teardown
  end

end
