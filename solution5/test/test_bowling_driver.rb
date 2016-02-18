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
    driver.add_player({ first: "Suzy", last: "Riska" }) do |player|
      assert_equal("Suzy", player.name[:first])
      @mock_io.write "#{player.to_s} Added!"
      assert_equal("S. Riska Added!", @mock_io.output)
    end
  end

  def test_adds_players_forever
    driver.add_players do |players|
      assert_equal(3, players.length)
      assert_equal("S. Riska", players[0].to_s)
      assert_equal("N. Jacobs", players[1].to_s)
      assert_equal("N. Jr.", players[2].to_s)
    end

    @mock_io.reset

    driver.add_players do |players|
      assert_equal(6, players.length)
      assert_equal("S. Riska", players[3].to_s)
      assert_equal("N. Jacobs", players[4].to_s)
      assert_equal("N. Jr.", players[5].to_s)
    end

    @mock_io.reset

    driver.add_players do |players|
      assert_equal(9, players.length)
      assert_equal("S. Riska", players[6].to_s)
      assert_equal("N. Jacobs", players[7].to_s)
      assert_equal("N. Jr.", players[8].to_s)
    end
  end

  def test_plays_frame
    driver.add_players { |players| }
    driver.play_frame do |game_status|
      player_1 = game_status[:players][0]
      player_2 = game_status[:players][1]
      player_3 = game_status[:players][2]
      assert_equal([10], player_1.game.rolls)
      assert_equal([5, 5], player_2.game.rolls)
      assert_equal([1, 0], player_3.game.rolls)
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
    driver.play
  end

end
