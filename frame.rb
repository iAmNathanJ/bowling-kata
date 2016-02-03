class Frame

  attr_reader :score, :rolls, :pins, :complete

  def initialize
    @score = 0
    @rolls = 0
    @pins = 0
    @complete = false
  end

  def bowl

    raise "You're out of rolls, my friend." if @rolls >= 2

    @rolls += 1
    @pins += (rand * (10-@pins)).round

    if @pins == 10 || @rolls == 2
      @complete = true
    end

  end

  def get_score(extra_1 = 0, extra_2 = 0)
    pins + extra_1 + extra_2
  end

end
