module SimpleQuest

  GEM_CONFIG = HashWithIndifferentAccess.new(YAML.load(File.read("./config/gems.yml")))
  GRUE_CONFIG = HashWithIndifferentAccess.new(YAML.load(File.read("./config/grues.yml")))
  PLAYER_CONFIG = HashWithIndifferentAccess.new(YAML.load(File.read("./config/players.yml")))
  ROOM_CONFIG = YAML.load(File.read("./config/rooms.yml")).map(&:with_indifferent_access)
  VALID_ACTIONS = ["north", "east", "south", "west", "map", "help", "quit", "exit", "room", "location"]

  class Game

    attr_accessor :player,
                  :grue,
                  :map

    def initialize
      self.map = Map.new
      map.ensure_one_teleport_room
      map.scatter_gems if GEM_CONFIG[:scatter_on_new_game]
      display_intro
      display_instructions
      self.player = Player.new(map.rooms)
      self.grue = Grue.new(map.rooms - [player.room]) # Ensure that the grue doesn't spawn in the same room as the player
      start_game
    end

    def start_game
      display_location_info
      until won? || player.dead? do
        prompt_for_action
      end
      display_outro
      exit
    end

    def prompt_for_action
      Game.display_divider "Turn: #{player.turn} | Gems: #{player.gems} / #{GEM_CONFIG[:goal]} | Lives: #{player.lives}"
      print "Action: "
      parse_action gets.chomp
    end

    def parse_action(action)
      unless VALID_ACTIONS.include?(action.downcase)
        puts "Invalid action. Type 'help' for available actions."
        return
      end

      case action.downcase
      when "north", "east", "south", "west"
        player.move(map, action)
        if grue.room == player.room
          puts "The grue was just here! It dropped a gem and fled..."
          grue.flee(map)
          player.collect_gem
        end
      when "map"
        Map.display
      when "room", "location"
        display_location_info
      when "help"
        display_instructions
      when "quit", "exit"
        exit
      end
    end

    def display_location_info
      Game.display_divider "Location"
      puts "You are currently located in the #{player.room.name.titleize} room."
      puts "#{map.teleport_rooms.size == 1 ? 'Teleport is' : 'Teleports are'} located in the #{map.teleport_rooms.map(&:name).join(', ').titleize} #{map.teleport_rooms.size == 1 ? 'room' : 'rooms'}."
      # puts "Gems are located in #{map.gem_rooms.map(&:name).join(', ').titleize}."
      puts "The Grue is currently located in the #{grue.room.name.titleize} room."
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
      puts "room                     - Display your current location and location of any telelports."
      puts "help                     - Display this dialog."
      puts "exit, quit               - Exit the game."
    end

    def display_outro
      puts self.won? ? "You won in #{player.turn} turns!" : "You lost!"
    end

    def won?
      player.gems >= 5 && player.room.teleport
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