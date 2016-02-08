class BowlingGame

  def score_game(fs)
    fs.each_with_index.map do |roll, i|
      if roll == "X"
        if(fs.length - i > 3)
          calc_strike(i, fs)
        else
          10
        end
      elsif roll == "/"
        if(fs.length - i > 2)
          calc_spare(i, fs)
        else
          5
        end
      else
        roll
      end
    end.reduce(:+)
  end

  def pins(roll, i, fs)
    if roll == "/"
      10 - fs[i-1]
    elsif roll == "X"
      10
    else
      roll
    end
  end

  def calc_strike(i, fs)
    if fs.length - i > 2
      pins("X", i, fs) + pins(fs[i+1], i+1, fs) + pins(fs[i+2], i+2, fs)
    else
      10
    end
  end

  def calc_spare(i, fs)
    pins("/", i, fs) + pins(fs[i+1], i+1, fs)
  end

end
