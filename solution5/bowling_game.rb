class BowlingGame

  attr_accessor :rolls

  def initialize
    @rolls = []
  end

  def bowl(pins)
    rolls << pins
  end

  def score
    points = []
    cur_roll = 0
    10.times do
      points << rolls.fetch(cur_roll, 0)
      cur_roll += 1
      if points.last == 10
        points << rolls.fetch(cur_roll, 0) << rolls.fetch(cur_roll+1, 0)
        next
      end
      if points.last + rolls.fetch(cur_roll, 0) == 10
        points << rolls.fetch(cur_roll+1, 0)
      end
      points << rolls.fetch(cur_roll, 0)
      cur_roll += 1
    end
    points.reduce(:+)
  end

end