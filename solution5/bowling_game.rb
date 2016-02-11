####################################
# Solution inspired by Yock & Cat
####################################

class BowlingGame

  attr_accessor :rolls

  def initialize
    @rolls = []
  end

  def bowl(pins)
    rolls << pins
  end

  def score(rollz)
    points = []
    cur_roll = 0
    10.times do
      points << rollz.fetch(cur_roll, 0)
      cur_roll += 1
      if points.last == 10
        points << rollz.fetch(cur_roll, 0) << rollz.fetch(cur_roll+1, 0)
        next
      end
      if points.last + rollz.fetch(cur_roll, 0) == 10
        points << rollz.fetch(cur_roll+1, 0)
      end
      points << rollz.fetch(cur_roll, 0)
      cur_roll += 1
    end
    points.reduce(:+)
  end

  private
  def shift(arr)
    (arr.shift || 0)
  end

end
