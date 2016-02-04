require_relative "frame"

class BowlingGame

  attr_accessor :frames

  def initialize
    @frames = build_frames
  end

  def score_frame(frame)
    if frame.strike?
      "x"
    elsif frame.spare?
      [frame.rolls[0], "/"]
    else
      frame.rolls
    end
  end

  def all_rolls
    @frames.inject([]) do |rolls, frame|
      rolls << score_frame(frame)
    end.flatten
  end

  def score_game
    all_rolls.each_with_index.map do |roll, i|
      if(roll == "x")
        # add_frame! if i == 9
        10 + to_num(all_rolls)[i+1] + to_num(all_rolls)[i+2]
      elsif(roll == "/")
        # add_frame! if i == 9
        to_num(all_rolls)[i] + to_num(all_rolls)[i+1]
      else
        roll
      end
    end.inject(:+)
  end

  def to_num(arr)
    arr.each_with_index.map do |item, i|
      if item == "x"
        10
      elsif item == "/"
        10 - arr[i-1]
      else
        item
      end
    end
  end


  ### PRIVATE ##############################
  private

  def auto_play
    frames.each do |frame|
      2.times do
        frame.bowl unless frame.closed?
      end
    end
    frames << Frame.new if score_frame(@frames[9]) == 'x'
  end

  def add_frame!
    frames << Frame.new if score_frame(@frames[9]) == 'x'
  end

  def build_frames
    (1..10).inject([]) do |frames|
      frames << Frame.new
    end
  end

end

# game = BowlingGame.new
# game.auto_play
# p game.all_rolls
