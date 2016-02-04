class Frame

  attr_reader :rolls

  def initialize
    @rolls = []
  end

  def bowl(p = (rand * (10-pins)).round)
    raise "This frame is closed." if closed?
    @rolls << (p > 10 ? 10 : p)
  end

  def pins
    @rolls.inject(:+) || 0
  end

  def closed?
    @rolls.length == 2 || pins == 10
  end

end
