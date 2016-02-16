require_relative 'bowling_game'

class Console
  def write(msg); print msg; end
  def request(msg); print msg; gets.chomp; end
end

class BowlingGameDriver

  attr_reader :status

  def initialize(io)
    @status = { :players => [] }
    @io = io
  end

  def add_player(name)
    status[:players] << {
      :name => name,
      :game => BowlingGame.new
    }
    yield(status[:players].last)
  end

  def add_players
    adding_players = true

    while adding_players
      # Get player name
      player_name = @io.request "Add a player (name) "

      # Add player
      add_player(player_name) { |player| @io.write "\n#{player[:name]} Added!\n\n" }

      # Add another player?
      again = @io.request("Add another? (y/n) ").downcase
      adding_players = (again == "y" ? true : false)
    end
    yield(status[:players])
  end

  def play_frame

    # Loop thru players
    status[:players].each do |player|

      # Get first roll
      roll_1 = @io.request("#{player[:name]}: How many pins would you like to knock down? ").to_i
      player[:game].bowl(roll_1)

      # If strike, next player is up
      if roll_1 == 10
        @io.write "\nSTRIKE!!\n\n"
        next

      # Otherwise, roll again
      else
        @io.write "\nYou have #{10 - roll_1} pins left.\n"
        roll_2 = @io.request("How many pins would you like to knock down? ").to_i
        player[:game].bowl(roll_2)

        if(roll_1 + roll_2 == 10)
          @io.write "\nSPARE!\n\n"
        else
          @io.write "\nTotal pins for that frame: #{roll_1 + roll_2}\n\n"
        end
      end
    end
    yield(status)
  end

  def play
    add_players do |players|
      player_list = []
      players.each { |player| player_list << player[:name] }
      @io.write "\nPlayers added: #{player_list.join(', ')}\n\n"
    end

    10.times do
      play_frame do |stats|
        @io.write "=================\n"
        @io.write "Current Scores\n"
        stats[:players].each { |player| @io.write "#{player[:name]}: #{player[:game].score}\n" }
        @io.write "=================\n"
      end
    end
  end

  def all_players_done?

  end

  def winner
    # if all players game is NOT done return false
    # check which player has highest score / return player
    # players.reduce do |winner, player|
    #   winner[:score] > player[:score] ? winner : player
    # end
  end

end
