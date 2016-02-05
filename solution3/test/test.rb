require "test/unit"
require_relative "mock"
require_relative "../bowling_game"

class TestBowling < Test::Unit::TestCase

  attr_accessor :frameset

  def setup
    @game = BowlingGame.new
    @frameset = Frameset.frameset
  end

  def test_stuff
  end

end
