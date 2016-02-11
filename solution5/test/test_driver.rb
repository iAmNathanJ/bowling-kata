require "test/unit"
require_relative "../game_driver"
require_relative "mock"

class TestGameDriver < Test::Unit::TestCase

  attr_accessor :driver

  def setup
    @driver = GameDriver.new(MockGame)
  end

  def test_driver_is_a_thing
    assert_not_nil(driver, "Driver doesn't exist.")
  end

  def test_driver_accepts_turn
  end

  def test_driver_contains_players
  end

  def teardown
  end

end
