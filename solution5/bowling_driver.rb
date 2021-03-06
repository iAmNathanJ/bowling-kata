require_relative "bowling_game"
require_relative "player"

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
    status[:players] << Player.new(name, BowlingGame.new)
    yield(status[:players].last)
  end

  def add_players
    adding_players = true

    while adding_players
      # Get player name
      @io.write "Add a player\n"
      first_name = @io.request "(first name) "
      last_name = @io.request "(last name) "

      player_name = {
        first: first_name,
        last: last_name
      }

      # Add player
      add_player(player_name) { |player| @io.write "\n#{player.to_s} Added!\n\n" }

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
      roll_1 = @io.request("#{player.to_s}: How many pins would you like to knock down? ").to_i
      player.game.bowl(roll_1)

      # If strike, next player is up
      if roll_1 == 10
        @io.write "\nSTRIKE!!\n\n"
        next

      # Otherwise, roll again
      else
        @io.write "\nYou have #{10 - roll_1} pins left.\n"
        roll_2 = @io.request("How many pins would you like to knock down? ").to_i
        player.game.bowl(roll_2)

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
      players.each { |player| player_list << player.to_s }
      @io.write "\nPlayers added: #{player_list.join(', ')}\n\n"
    end

    begin
      play_frame do |stats|
        @io.write "=================\n"
        @io.write "Current Scores\n"
        stats[:players].each { |player| @io.write "#{player.to_s}: #{player.game.score}\n" }
        @io.write "=================\n"
      end
    end while(!all_done?)
    @io.write("#{game_winner.to_s} is the winner!")
  end

  def all_done?
    done = true
    status[:players].each do |player|
      if !player.game.complete?
        done = false
        break
      end
    end
    done
  end

  def game_winner
    status[:players].reduce do |winner, next_player|
      (winner.game.score > next_player.game.score) ? winner : next_player
    end
  end

end
