require_relative "frame"

class BowlingGame

  attr_accessor :frames

  def initialize
    @frames = build_frames
  end

  def score_frame(frame)
    if frame.pins == 10
      frame.rolls.length == 1 ? 'x' : '/'
    else
      frame.rolls
    end
  end

  def auto_play
    @frames.each do |frame|
      begin
        2.times do
          frame.bowl unless frame.closed?
        end
        p score_frame(frame)
      rescue => e
        e.message
      end
    end
    @frames << Frame.new if score_frame(@frames[9]) == 'x' || '/'
  end

  def score_game
    i = 0
    @frames.inject(0) do |score, frame|
      i += 1
      modifier = if score_frame(frame) == "x"
        @frames[i].pins
      elsif score_frame(frame) == "/"
        @frames[i].rolls[0]
      end
      score + frame.pins + (modifier || 0)
    end
  end

  private

  def build_frames
    (1..10).inject([]) do |frames|
      frames << Frame.new
    end
  end

end

game = BowlingGame.new
game.auto_play
p game.score_game
