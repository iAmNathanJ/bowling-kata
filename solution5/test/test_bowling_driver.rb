require "test/unit"
require_relative "../bowling_driver"
require_relative "mock"

class TestBowlingDriver < Test::Unit::TestCase

  attr_accessor :driver

  def setup
    @mock_io = MockIO.new
    @driver = BowlingGameDriver.new(@mock_io)
  end

  def teardown
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
      assert_equal("S. Riska", driver.player_to_s(players[0]))
      assert_equal("N. Jacobs", driver.player_to_s(players[1]))
      assert_equal("N. Jr.", driver.player_to_s(players[2]))
    end

    @mock_io.reset

    driver.add_players do |players|
      assert_equal(6, players.length)
      assert_equal("S. Riska", driver.player_to_s(players[3]))
      assert_equal("N. Jacobs", driver.player_to_s(players[4]))
      assert_equal("N. Jr.", driver.player_to_s(players[5]))
    end

    @mock_io.reset

    driver.add_players do |players|
      assert_equal(9, players.length)
      assert_equal("S. Riska", driver.player_to_s(players[6]))
      assert_equal("N. Jacobs", driver.player_to_s(players[7]))
      assert_equal("N. Jr.", driver.player_to_s(players[8]))
    end
  end

  def test_plays_frame
    driver.add_players { |players| }
    driver.play_frame do |game_status|
      player_1 = game_status[:players][0]
      player_2 = game_status[:players][1]
      player_3 = game_status[:players][2]
      assert_equal([10], player_1[:game].rolls)
      assert_equal([5, 5], player_2[:game].rolls)
      assert_equal([1, 0], player_3[:game].rolls)
    end

    @mock_io.reset
  end

  def test_game_done
    driver.add_players { |players| }
    10.times do
      driver.play_frame { |game_status| }
    end
  end

  def test_plays_all_frames
    # driver.play
  end

end
