require_relative 'bowling_game'

class BowlingGameDriver

  attr_reader :winner
  attr_accessor :players

  def initialize
    @players = Hash.new
    @game = BowlingGame
    @winner = nil
  end

  def add_player(name)
    id = name.downcase
    if players[id]
      raise Exception.new("Name already exists")
    end
    players[id] = {
      :name => name,
      :game => @game.new,
      :score => 0
    }
  end

  def get_score(player)
    players[player][:score]
  end

  def update_score(player, points)
    players[player][:score] += points
  end

  def add_players
    add_another_player = true
    prompt "Add a player (name)"
    while add_another_player
      add_player(gets.chomp)
      prompt "Add another? (y/n)"
      if gets.chomp.to_lower != y
        add_another_player = false
      end
    end
  end

end
