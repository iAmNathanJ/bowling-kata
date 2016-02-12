class Game

  attr_accessor :players

  def initialize(game_class, driver)
    @game = game_class
    @driver = driver.new
    @players = Hash.new
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

  def go
    @driver.send(drive)
  end

  def method_missing(method, *args, block)
    @game.send(method, *args, block)
  end


end
