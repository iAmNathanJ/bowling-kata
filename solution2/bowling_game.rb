require_relative "test/mock"

class BowlingGame

  def score_game(fs)
    i = 0 # represents next frame
    fs.inject(0) do |total, frame|
      i += 1
      score = frame[:rolls].inject(:+)
      if frame[:strike]
        if fs[i][:strike]
          score += fs[i][:rolls][0] + fs[i+1][:rolls][0]
        else
          score += fs[i][:rolls][0] + fs[i][:rolls][1]
        end
      elsif frame[:spare]
        score += fs[i][:rolls][0]
      end
      total + (i < 11 ? score: 0)
    end
  end
end
