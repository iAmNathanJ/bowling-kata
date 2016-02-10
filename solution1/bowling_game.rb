require_relative "frame"

class BowlingGame

  MAX_FRAMES = 10

  attr_accessor :frames

  def initialize
    @frames = [Frame.new]
  end

  def current_frame_num
    frames.length - 1
  end

  def current_frame
    frames[current_frame_num]
  end

  def advance_frame
    if current_frame.done? && frames.size < MAX_FRAMES
      frames << Frame.new
    end
  end

  def offset_frame(n)
    frames[current_frame_num + n]
  end

  def bowl(pins)
    current_frame.add(pins)
    resolve_frames(pins)
    advance_frame
  end

  

  # def resolve_frames(pins)
  #   if current_frame_num > 0
  #     f1 = offset_frame(-1)
  #     f1.modify(pins) if f1.spare? || f1.strike?
  #   end
  #   if current_frame_num > 1
  #     f2 = offset_frame(-2)
  #     f2.modify(pins) if f2.strike?
  #   end
  # end

  def score_all_frames
    frames.reduce(0) do |total, frame|
      total + frame.total
    end
  end

  def score_extra_rolls
    0
  end

  def score
    score_all_frames + score_extra_rolls
  end

end
