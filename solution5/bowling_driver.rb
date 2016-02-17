require_relative "bowling_game"

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

  def player_to_s(player)
    "#{player[:name][:first][0]}. #{player[:name][:last]}"
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
      add_player(player_name) { |player| @io.write "\n#{player_to_s(player)} Added!\n\n" }

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
      roll_1 = @io.request("#{player_to_s(player)}: How many pins would you like to knock down? ").to_i
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
      players.each { |player| player_list << player_to_s(player) }
      @io.write "\nPlayers added: #{player_list.join(', ')}\n\n"
    end

    begin
      play_frame do |stats|
        @io.write "=================\n"
        @io.write "Current Scores\n"
        stats[:players].each { |player| @io.write "#{player_to_s(player)}: #{player[:game].score}\n" }
        @io.write "=================\n"
      end
    end while(!all_done?)
    @io.write(winner)
  end

  def all_done?
    done = true
    status[:players].each do |player|
      if !player[:game].complete?
        done = false
        break
      end
    end
    done
  end

  def winner
    status[:players].reduce do |winner, player|
      winner[:game].score > player[:game].score ? winner[:game].score : player[:game].score
    end
  end

end
