require_relative "frame"

class BowlingGame

  attr_accessor :frames, :current_frame

  def initialize
    @frames = build_frames
    @current_frame = 0
  end

  def next_frame
    @current_frame += 1
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
        next_frame
        p score_frame(frame)
      rescue => e
        e.message
      end
    end
  end

  def score_game
    @frames.inject(0) do |score, frame|
      score + score_frame(frame)
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
