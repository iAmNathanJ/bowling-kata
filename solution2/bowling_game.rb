require_relative "test/mock"

class BowlingGame

  attr_accessor :frames

  def initialize
    @frames = []
    @next = 0

    10.times do
      add_frame
    end
  end

  def bowl(pins)
    current_frame.rolls << pins
  end

  def score_game(fs)
    i = 0
    fs.inject(0) do |total, frame|
      i += 1
      score = frame_total(frame)
      if frame[:strike]
        if fs[i][:strike]
          score += fs[i][:rolls][0] + fs[i+1][:rolls][0]
        else
          score += fs[i][:rolls][0] + fs[i][:rolls][1]
        end
      elsif frame[:spare]
        score += fs[i][:rolls][0]
      end
      total + score
    end
  end


  ### PRIVATE ###################################
  private
  def add_frame
    frames << {
      :strike   => false,
      :spare    => false,
      :rolls    => [],
      :complete => false
    }
  end

  def frame_total(frame)
    frame[:rolls].inject(:+)
  end

end
