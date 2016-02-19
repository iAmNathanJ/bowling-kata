require "test/unit"
require_relative "../bowling_driver"
require_relative "mock"

class TestBowlingDriver < Test::Unit::TestCase

  attr_accessor :driver

  def setup
    @mock_io = MockIO.new

    @mock_io.add_requests({
      request: "(first name)",
      response: ["Suzy", "Nate", "Nathan"]
    },
    {
      request: "(last name)",
      response: ["Riska", "Jacobs", "Jr."]
    },
    {
      request: "Add another?",
      response: ["y", "y", "n"]
    })

    @driver = BowlingGameDriver.new(@mock_io)
  end

  def teardown
  end

  def test_driver_has_players
    players = driver.status[:players]
    assert_equal(Array, players.class)
  end

  def test_players_can_be_added
    driver.add_player({ first: "Suzy", last: "Riska" }) do |player|
      assert_not_nil(player)
    end
  end

  def test_adds_players_until_input_is_n
    driver.add_players do |players|
      assert_equal(3, players.length)
    end

    @mock_io.reset_response_queue("Add another?")
    @mock_io.add_response("(first name)", "Ryan", "Rob", "Bryan")
    @mock_io.add_response("(last name)", "Cromwell", "Tarr", "Braun")

    driver.add_players do |players|
      assert_equal(6, players.length)
      assert_equal("R. Cromwell", players[3].to_s)
      assert_equal("R. Tarr", players[4].to_s)
      assert_equal("B. Braun", players[5].to_s)
    end
  end

  def test_plays_frame
    driver.add_players { |players| }
    assert_nothing_thrown do
      driver.play_frame { |game_status| }
    end
  end

  def test_playing_frame_updates_player_scores

    @mock_io.add_requests({
      request: "How many pins would you like to knock down?",
      response: [10, 5, 5, 1, 1, 10, 5, 4, 1, 1]
    })

    driver.add_players { |players| }
    # play first frame
    driver.play_frame { |game_status| }
    # play second frame and test scores
    driver.play_frame do |game_status|
      player_1 = game_status[:players][0]
      player_2 = game_status[:players][1]
      player_3 = game_status[:players][2]
      assert_equal(30, player_1.game.score)
      assert_equal(24, player_2.game.score)
      assert_equal(4, player_3.game.score)
    end
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
