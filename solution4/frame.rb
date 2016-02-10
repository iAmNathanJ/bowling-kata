class Frame

  attr_accessor :rolls, :modifier

  def initialize
    @rolls = []
    @modifier = 0
  end

  def add(pins)
    rolls << pins
  end

  def modify(pins)
    @modifier += pins
  end

  def total_rolls
    rolls.reduce(:+) || 0
  end

  def total
    total_rolls + modifier
  end

  def spare?
    rolls.size == 2 && total_rolls == 10
  end

  def strike?
    rolls.size == 1 && total_rolls == 10
  end

  def done?
    strike? || rolls.size == 2
  end

end
