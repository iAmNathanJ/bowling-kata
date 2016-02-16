class BowlingGame

  MAX_FRAMES = MAX_PINS = 10

  attr_reader :rolls

  def initialize
    @rolls = []
  end

  def bowl(pins)
    rolls << pins
  end

  def score
    points = []
    cur_roll = 0
    MAX_FRAMES.times do
      points << rolls.fetch(cur_roll, 0)
      cur_roll += 1
      if points.last == MAX_PINS
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

  def all_frames
    frames = []
    i = 0
    while i < rolls.length do
      if rolls[i] == MAX_PINS
        frames << rolls.slice(i, 1)
        i += 1
      else
        frames << rolls.slice(i, 2)
        i += 2
      end
    end
    frames
  end

  def frames
    all_frames.slice(0, MAX_FRAMES) || []
  end

  def extra_rolls
    extras = all_frames.slice(MAX_FRAMES, 2) || []
    extras.flatten
  end

  def current_frame
    frames.last
  end

  def current_frame_num
    frames.length
  end

  def complete?
    false unless current_frame_num == MAX_FRAMES
    if strike?(current_frame) && extra_rolls.length == 2
      true
    elsif spare?(current_frame) && extra_rolls.length == 1
      true
    elsif !spare?(current_frame) && current_frame.length == 2
      true
    else
      false
    end
  end

  private
  def strike?(rolls)
    (rolls.length == 1 && rolls.reduce(:+) == MAX_PINS) ? true : false
  end

  def spare?(rolls)
    (rolls.length == 2 && rolls.reduce(:+) == MAX_PINS) ? true : false
  end
end
