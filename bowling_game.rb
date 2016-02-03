require_relative "frame"

class BowlingGame

  attr_reader :frames

  def initialize
    @frames = []
    for i in (1..10)
      @frames << Frame.new
    end
  end

end
