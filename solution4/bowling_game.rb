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
    10.times do
      if(points << shift(rollz)).last == 10
        points << rollz.fetch(0, 0) << rollz.fetch(1, 0)
        next
      end
      if points.last + (points << shift(rollz)).last == 10
        points << rollz.fetch(0, 0)
      end
    end
    points.reduce(:+)
  end

  private
  def shift(arr)
    (arr.shift || 0)
  end

end
