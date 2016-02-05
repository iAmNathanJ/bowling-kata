class Frame

  attr_accessor :rolls

  def initialize
    @rolls = []
  end

  def bowl(p = (rand * (10-pins)).round)
    raise "This frame is closed." if closed?
    rolls << max_roll(p)
  end

  def pins
    rolls.inject(:+) || 0
  end

  def strike?
    pins == 10 && rolls.length == 1
  end

  def spare?
    pins == 10 && rolls.length == 2
  end


  ### PRIVATE ##############################
  private

  def closed?
    rolls.length == 2 || pins == 10
  end

  def max_roll(p)
    remaining_pins = 10 - pins
    p > remaining_pins ? remaining_pins : p
  end

end
