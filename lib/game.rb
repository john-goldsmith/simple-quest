module SimpleQuest

  GEM_CONFIG = HashWithIndifferentAccess.new(YAML.load(File.read("./config/gems.yml")))
  GRUE_CONFIG = HashWithIndifferentAccess.new(YAML.load(File.read("./config/grues.yml")))
  PLAYER_CONFIG = HashWithIndifferentAccess.new(YAML.load(File.read("./config/players.yml")))
  ROOM_CONFIG = YAML.load(File.read("./config/rooms.yml")).map(&:with_indifferent_access)

  class Game

    attr_accessor :player,
                  :grue,
                  :map,
                  :turn

    def initialize
      self.map = Map.new
      map.ensure_one_teleport_room
      display_intro
      display_instructions
      self.player = Player.new
      self.grue = Grue.new
      self.turn = 0
      start_game
    end

    def start_game
      display_location_info
      until won? || player.dead? do
        prompt_for_action
      end
    end

    def prompt_for_action
      Game.display_divider "Turn #{self.turn} (Lives: #{player.lives})"
      print "Action: "
      parse_action gets.chomp
    end

    def parse_action(action)
      case action.downcase
      when "north", "east", "south", "west"
        player.move action
        increment_turn
      when "map"
        Map.display
      when "room"
        display_location_info
      when "help"
        display_instructions
      when "quit", "exit"
        exit
      else
        puts "Invalid action. Type 'help' for available actions."
      end
    end

    def display_location_info
      Game.display_divider "Location"
      puts "You are currently in the #{player.room[:name].titleize} room."
      puts "Teleports are located in the #{map.teleports.map(&:name).join(', ').titleize} room(s)."
    end

    def increment_turn
      self.turn += 1
    end

    def display_intro
      Game.clear_screen
      puts "\n"
      puts "Welcome to..."
      puts "\n"
      puts '   _____ _                 __        ____                  __'
      puts '  / ___/(_)___ ___  ____  / /__     / __ \__  _____  _____/ /_'
      puts '  \__ \/ / __ `__ \/ __ \/ / _ \   / / / / / / / _ \/ ___/ __/'
      puts ' ___/ / / / / / / / /_/ / /  __/  / /_/ / /_/ /  __(__  ) /_'
      puts '/____/_/_/ /_/ /_/ .___/_/\___/   \___\_\__,_/\___/____/\__/'
      puts '                /_/'
    end

    def display_instructions
      Game.display_divider "Instructions"
      puts "north, east, south, west - Move in a direction."
      puts "map                      - Display the map."
      puts "room                     - Display the current room."
      puts "room                     - Display the current room."
      puts "exit, quit               - Exit the game."
    end

    def display_outro
      puts self.won? ? "You won!" : "You lost!"
    end

    def won?
      player.gems >= 5 && @player.current_room.teleport?
    end

    def self.clear_screen
      puts `clear` # TODO: This won't work on Windows
    end

    def self.display_divider(label=nil)
      puts "\n"
      if label
        puts "#{'-'*20} #{label} #{'-'*20}"
      else
        puts "-"*62
      end
      puts "\n"
    end

  end

end