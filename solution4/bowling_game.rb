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

  def score
    score = []
    rollz = rolls
    10.times do
      if(score << shift(rollz)).last == 10
        score << rollz.fetch(0, 0) << rollz.fetch(1, 0)
        next
      end
      if score.last + (score << shift(rollz)).last == 10
        score << rollz.fetch(0, 0)
        next
      end
    end
    score.reduce(:+)
  end

  private
  def shift(arr)
    (arr.shift || 0)
  end

end
