class Player

  attr_reader :name
  attr_accessor :game

  def initialize(name, game)
    @name = name
    @game = game
  end

  def to_s
    "#{@name[:first][0]}. #{@name[:last]}"
  end
end
